import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/verification_status.dart';
import '../../model/user/user_model.dart';
import '../general_provider.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref.read));

final userStreamProvider = StreamProvider.autoDispose((ref) {
  final id = auth.FirebaseAuth.instance.currentUser?.uid;
  final stream = FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .snapshots()
      .map((event) => User.fromJson(event.data()!));
  return stream;
});

class UserRepository {
  // static final UserRepository _instance = UserRepository._internal();
  // UserRepository._internal();
  // factory UserRepository() {
  //   return _instance;
  // }
  final Reader _reader;
  UserRepository(this._reader);

  User? _user;
  // final _firestore = FirebaseFirestore.instance;

  /// user を新規作成する
  Future<void> createUser(
    auth.User? user,
    String customerId,
    String accountId,
    String name,
  ) async {
    // await _firestore.collection('users').doc(user?.uid).set({
    await _reader(firebaseFirestoreProvider)
        .collection('users')
        .doc(user?.uid)
        .set({
      'id': user?.uid,
      // 'displayName': user?.displayName,
      'displayName': name,
      'email': user?.email,
      'customerId': customerId,
      'accountId': accountId,
      'status': Status.unverified.toEnumString,
      'bankStatus': Status.unverified.toEnumString,
      'chargesEnabled': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// 単一取得
  Future<User?> fetch() async {
    final id = auth.FirebaseAuth.instance.currentUser?.uid;
    // final doc = await _firestore.collection('users').doc(id).get();
    final doc = await _reader(firebaseFirestoreProvider)
        .collection('users')
        .doc(id)
        .get();
    final data = doc.data();
    if (data != null) {
      _user = User.fromJson(data);
    }
    return _user;
  }

  /// statusを返す
  Future<String> fetchStatus(String id) async {
    try {
      // final doc = await _firestore.collection('users').doc(id).get();
      final doc = await _reader(firebaseFirestoreProvider)
          .collection('users')
          .doc(id)
          .get();
      return doc.data()?['status'];
    } catch (e) {
      return 'unknown';
    }
  }

  /// statusを返す2
  Future<String> fetchBankStatus(String id) async {
    try {
      // final doc = await _firestore.collection('users').doc(id).get();
      final doc = await _reader(firebaseFirestoreProvider)
          .collection('users')
          .doc(id)
          .get();
      return doc.data()?['bankStatus'];
    } catch (e) {
      return 'unknown';
    }
  }

  /// ローカルキャッシュを削除
  void deleteLocalCache() {
    _user = null;
  }

  /// カード情報（IDのみ）を保存する
  Future updatePaymentMethod({required String sourceId}) async {
    final user = await fetch();
    // return _firestore.collection('users').doc(user?.id).update({
    return _reader(firebaseFirestoreProvider)
        .collection('users')
        .doc(user?.id)
        .update({
      'sourceId': sourceId,
    });
  }
}
