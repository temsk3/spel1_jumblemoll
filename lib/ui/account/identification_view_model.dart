import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';

import '../../data/model/stripe/stripe_individual.dart';
import '../../data/model/user/user_model.dart';
import '../../data/repository/stripe/stripe_repository.dart';
import '../../data/repository/user/user_repository.dart';
import '../../utils/validation_utils.dart';

final logger = Logger();

final identificationViewModelProvider =
// StateNotifierProvider.autoDispose<
//     IdentificationViewModel, AsyncValue<void>>(
//   (ref) => IdentificationViewModel(ref: ref),
// );
    ChangeNotifierProvider((ref) => IdentificationViewModel(ref.read));

class IdentificationViewModel extends ChangeNotifier {
  final Reader _read;
  IdentificationViewModel(this._read) : super() {
    fetchIndividual();
  }
// class IdentificationViewModel extends StateNotifier<AsyncValue<void>> {
//   final AutoDisposeStateNotifierProviderRef _ref;
//   IdentificationViewModel({required AutoDisposeStateNotifierProviderRef ref})
//       : _ref = ref,
//         super(const AsyncLoading()) {
//     // fetch();
//   }
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    // notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    // notifyListeners();
  }

  final String termText =
      '''Stripe Connectアカウント契約( https://stripe.com/jp/connect-account/legal )（Stripe利用規約( https://stripe.com/jp/legal )を含み、総称して「Stripeサービス契約」といいます。）''';
  final imageNoteText = '''
- 運転免許証
- パスポート
- 外国国籍を持つ方の場合は在留カード
- 写真付きの住基カード
- マイナンバーカード（顔写真入り）

画像について
- ファイルサイズ5MB以内
- 8000px以下
- .pngもしくは.jpgの形式
''';

  late final _userRepo = _read(userRepositoryProvider);
  late final _stripeRepo = _read(stripeRepositoryProvider);

  bool isAcceptTerm = false;
  StripeIndividual? individual;
  TosAcceptance? tosAcceptance;
  PlatformFile? identificationImageFront;
  PlatformFile? identificationImageBack;
  String? dobText; // そのまま送らない生年月日、validation用

  User? user;

  /// 本人情報を取得
  Future fetchIndividual() async {
    try {
      user = await _fetchUser();
      logger.d(user);
      final json = await _stripeRepo.retrieveConnectAccount(user);
      individual = StripeIndividual.fromJson(json);
      logger.d(individual);
    } catch (e) {
      log(e.toString());
      // 新しいの入れる
      individual = StripeIndividual();
    } finally {
      endLoading();
    }
  }

  /// Stripe に本人確認情報を送信する
  Future updateIndividual() async {
    startLoading();
    try {
      user = await _fetchUser();
      await _stripeRepo.updateConnectAccount(
        user,
        individual,
        tosAcceptance,
      );
    } catch (e) {
      log(e.toString());
    } finally {
      endLoading();
    }
  }

  /// 生年月日
  void setDob(String dobText) {
    this.dobText = dobText;

    if (ValidationUtils.validateDob(dobText) != '') {
      return;
    }

    final List<String> dobArray = dobText.split('/');
    final newDob = Dob();
    newDob.year = int.parse(dobArray[0]);
    newDob.month = int.parse(dobArray[1]);
    newDob.day = int.parse(dobArray[2]);
    individual?.dob = newDob;
  }

  /// 利用規約
  Future<void> setTosAcceptance(bool value) async {
    isAcceptTerm = value;
    // notifyListeners();

    if (isAcceptTerm) {
      // 利用規約
      final int date = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
      final ip = await _getIP();
      tosAcceptance = TosAcceptance();
      tosAcceptance?.date = date;
      tosAcceptance?.ip = ip;
    }
  }

  /// 身分証明書のアップロード
  Future uploadIdImages() async {
    startLoading();

    try {
      // 本人確認画像
      final imageIdFront = await _uploadPhoto(identificationImageFront!);
      final imageIdBack = await _uploadPhoto(identificationImageBack!);

      final document = StripeDocument(imageIdFront, imageIdBack);
      final verification = StripeVerification(document);
      individual?.verification = verification;

      final user = await _fetchUser();
      await _stripeRepo.updateConnectAccount(
        user,
        individual,
        tosAcceptance,
      );
    } catch (e) {
      log(e.toString());
    } finally {
      endLoading();
    }
  }

  /// user ドキュメントを返す
  Future<User?> _fetchUser() async {
    final user = await _userRepo.fetch();
    logger.d(user!.id);
    return user;
  }

  /// IPアドレスを返す
  Future<String> _getIP() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '';
      }
    } catch (e) {
      log(e.toString());
      return '';
    }
  }

  /// 身分証明画像をピックする（オモテ）
  void showIdentificationImageFrontPicker() {
    _selectImage(onSelected: (file) {
      identificationImageFront = file;
      // notifyListeners();
    });
  }

  /// 身分証明画像をピックする（ウラ）
  void showIdentificationImageBackPicker() {
    _selectImage(onSelected: (file) {
      identificationImageBack = file;
      // notifyListeners();
    });
  }

  /// ローカルのファイル選択
  Future<void> _selectImage(
      {required Function(PlatformFile file) onSelected}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
      withData: true,
    );
    if (result == null) {
      return;
    }
    PlatformFile file = result.files.first;
    onSelected(file);
  }

  /// Stripe に画像をアップロードする
  Future<String> _uploadPhoto(PlatformFile file) async {
    const method = 'POST';
    final key = dotenv.env['STRIPE_PK'] as String;
    final uri = Uri.parse('https://files.stripe.com/v1/files');

    final headers = <String, String>{};
    headers['Accept-Charset'] = StripeApiHandler.charset;
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['User-Agent'] = 'StripeSDK/v2';
    headers['Authorization'] = 'Bearer $key';

    final request = http.MultipartRequest(method, uri);
    request.headers.addAll(headers);

    final imageValue = http.MultipartFile.fromBytes(
      'file',
      file.bytes!,
      filename: file.name,
    );
    request.files.add(imageValue);

    request.fields.addAll({
      'purpose': 'identity_document',
    });

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final status = response.statusCode;
    final body = response.body;
    final json = jsonDecode(body) as Map;

    if (status == 200) {
      final String id = json['id'];
      return id;
    } else {
      final errorMessage = json['error']['message'];
      throw (errorMessage);
    }
  }
}
