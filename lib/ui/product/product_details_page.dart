import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../data/model/bazaar/bazaar_model.dart';
import '../../data/model/product/product_model.dart';
import '../../data/repository/auth/auth_repository.dart';
import '../../data/repository/bazaar/bazaar_repository_impal.dart';
import '../../data/repository/product/product_repository_impal.dart';
import '../../data/repository/user/user_repository.dart';
import '../../ui/order/order_view_model.dart';
import '../common/alertdialog.dart';
import '../common/show_dialog.dart';
import '../hooks/use_l10n.dart';
import '../hooks/use_media_query.dart';
import '../hooks/use_router.dart';
import '../theme/app_theme.dart';
import 'product_view_model.dart';
import 'widget/picture.dart';

final logger = Logger();

class ProductDetailsPage extends HookConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    @PathParam('productId') this.index,
    this.bazaarEvent,
    this.productItem,
  }) : super(key: key);
  final index;
  final bazaarEvent;
  final productItem;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMQ = useMediaQuery();
    final state = ref.watch(productViewModelProvider);
    final viewModel = ref.watch(productViewModelProvider.notifier);
    final asyncValue = ref.watch(productListStreamProvider);
    //
    // final NumberFormat numFormatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());
    // final DateFormat dateFormatter =
    //     DateFormat.yMMMEd(Localizations.localeOf(context).toString());
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    //
    Product product;
    Bazaar bazaar;
    final owner = useState<bool>(false);
    final supporter = useState<bool>(false);
    final authState = ref.watch(authStateProvider);

    final order = useState<bool>(false);
    final edit = useState<bool>(false);
    final update = useState<bool>(false);
    final add = useState<bool>(false);

    final form = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    bool isOpened = false;

    String? organizer;
    String? bazaarId;
    if (bazaarEvent == null) {
      bazaar = Bazaar.empty();
      order.value = true;
    } else {
      bazaar = bazaarEvent;
      organizer = bazaar.organizer;
      bazaarId = bazaar.id;
      final supported =
          ref.watch(supporterListStreamProvider(bazaar.id.toString()));
      authState.whenData(
        (data) {
          if (data != null) {
            if (data.uid == bazaar.organizer) {
              owner.value = true;
            } else {
              supported.whenData(
                (values) {
                  // supporter.value = value.contains(data.uid);
                  for (var value in values) {
                    if (value.uid == data.uid && value.isActive == true) {
                      supporter.value = true;
                    }
                  }
                },
              );
            }
          } else {
            owner.value = false;
            supporter.value = false;
          }
        },
      );
      if (owner.value == false || supporter.value == false) {
        order.value = true;
      }
      if (productItem != null) {
        if (owner.value == true || supporter.value == true) {
          update.value = true;
        }
      } else {
        update.value = true;
        add.value = true;
        edit.value = true;
      }
    }

    if (productItem == null) {
      product = Product.empty();
    } else {
      product = productItem;

      isOpened = (now.compareTo(product.salesStart as DateTime) >= 0 &&
          now.compareTo(product.salesEnd as DateTime) < 0);
    }

    //

    String uid = '';
    String userName = '';
    // bool supporter = false;
    //
    final quantity = useState<int>(1);

    final code = useTextEditingController(text: product.code);
    final name = useTextEditingController(text: product.name);
    final genre = useState(product.genre);
    final desc = useTextEditingController(text: product.desc);
    final stock = useTextEditingController(text: product.stock.toString());
    final price = useTextEditingController(text: product.price.toString());
    final expirationFrom = useTextEditingController(
        text: dateFormatter.format(product.expirationFrom != null
            ? product.expirationFrom as DateTime
            : bazaar.eventFrom as DateTime));
    final expirationTo = useTextEditingController(
        text: dateFormatter.format(product.expirationTo != null
            ? product.expirationTo as DateTime
            : bazaar.eventTo as DateTime));
    final oldPicture = useTextEditingController(text: product.picture1URL);
    //
    final ImagePicker picker = ImagePicker();
    var uint8List = useState<Uint8List?>(null);

    final user = ref.watch(userRepositoryProvider);
    final verified = useState<bool>(false);
    authState.whenData(
      (data) async {
        // print(data!.uid);
        final result = (await user.fetchStatus(data!.uid));
        uid = data.uid;
        userName = data.displayName.toString();
        if (result == 'verified') {
          verified.value = true;
        } else {
          // 7/21 22 用
          // verified.value = true;
          verified.value = false;
        }
      },
    );
    logger.d(uid);
    logger.d(userName);

    return asyncValue.when(
      data: (data) {
        // final product = data.productList[index];
        final stockList = List.generate(
            int.parse(product.stock.toString()), (index) => 1 + index);

        return Scaffold(
          // backgroundColor: theme.appColors.background,
          appBar: AppBar(
            // backgroundColor: theme.appColors.primary,
            // foregroundColor: theme.appColors.onPrimary,
            actions: [
              if (update.value && add.value == false)
                IconButton(
                    onPressed: () async {
                      // appRoute.pop();
                      var result = await customShowDialog(
                        context,
                        'delete',
                        'Do you want to delete it?',
                      );
                      if (result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            // backgroundColor: theme.appColors.error,
                            content: Text('Processing Data'),
                          ),
                        );
                        viewModel.deleteProduct(
                          productId: product.id.toString(),
                        );
                        appRoute.pop();
                      } else {}
                    },
                    icon: const Icon(Icons.delete)),
              if ((update.value && edit.value == false && add.value == false))
                IconButton(
                  onPressed: () async {
                    // appRoute.push(ProductEditRoute(index: index));
                    edit.value = true;
                  },
                  icon: const Icon(Icons.edit),
                ),
              if (edit.value && add.value == false)
                IconButton(
                  onPressed: () async {
                    if (form.currentState!.validate()) {
                      form.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Processing Data',
                            // style: theme.textTheme.h30
                            //     .copyWith(color: theme.appColors.onError),
                          ),
                        ),
                      );
                      final updateProduct = product.copyWith(
                        organizer: uid,
                        code: code.text,
                        name: name.text,
                        genre: genre.value,
                        desc: desc.text,
                        stock: int.parse(stock.text),
                        price: int.parse(price.text),
                        expirationFrom: DateTime.parse(expirationFrom.text),
                        expirationTo: DateTime.parse(expirationTo.text),
                        isPublished: true,
                      );
                      viewModel.updateProduct(
                          updateProduct: updateProduct,
                          newPicture1: uint8List.value,
                          oldPicture1: oldPicture.text);
                      // appRoute.pop(ProductDetailsRoute(index: index));
                      appRoute.pop();
                      edit.value = false;
                    }
                  },
                  icon: const Icon(Icons.save),
                ),
              if (add.value)
                IconButton(
                  onPressed: () async {
                    if (form.currentState!.validate()) {
                      form.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Processing Data',
                            // style: theme.textTheme.h30
                            //     .copyWith(color: theme.appColors.onError),
                          ),
                        ),
                      );
                      viewModel.addProduct(
                          organizer: organizer.toString(),
                          bazaarId: bazaarId.toString(),
                          bazaarName: bazaar.name.toString(),
                          salesStart: bazaar.salesStart as DateTime,
                          salesEnd: bazaar.salesEnd as DateTime,
                          register: uid,
                          code: code.text,
                          name: name.text,
                          genre: genre.value.toString(),
                          desc: desc.text,
                          stock: int.parse(stock.text),
                          price: int.parse(price.text),
                          expirationFrom: DateTime.parse(expirationFrom.text),
                          expirationTo: DateTime.parse(expirationTo.text),
                          isPublished: false,
                          picture1: (uint8List.value == null)
                              ? null
                              : (uint8List.value));
                      appRoute.pop();
                    }
                  },
                  icon: const Icon(Icons.save),
                ),
            ],
            title: Text(product.name.toString(), style: theme.textTheme.h50
                // .copyWith(color: theme.appColors.onPrimary),
                ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: appMQ.size.width >= 768 ? 400 : null,
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (edit.value)
                              ? () async {
                                  form.currentState!.save();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  uint8List.value = await image!.readAsBytes();
                                }
                              : (oldPicture != null || oldPicture != '')
                                  ? () {
                                      showGeneralDialog(
                                        transitionDuration:
                                            const Duration(milliseconds: 1000),
                                        barrierDismissible: true,
                                        barrierLabel: '',
                                        context: context,
                                        pageBuilder:
                                            (context, animation1, animation2) {
                                          return DefaultTextStyle(
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1!,
                                            child: Center(
                                              child: SizedBox(
                                                height: 500,
                                                width: 500,
                                                child: SingleChildScrollView(
                                                  child: Stack(
                                                    children: [
                                                      InteractiveViewer(
                                                        minScale: 0.1,
                                                        maxScale: 5,
                                                        child: Container(
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                oldPicture.text,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                      SafeArea(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: const Icon(
                                                              Icons.close),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  : null,
                          child: PictureDetail(
                            picture: uint8List.value,
                            oldPicture: oldPicture.text,
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                enabled: edit.value,
                                controller: code,
                                // style:
                                //     TextStyle(color: theme.appColors.onPrimary),
                                decoration:
                                    const InputDecoration(labelText: 'code'),
                                // validator: (value) {
                                // if (value == null || value.isEmpty) {
                                //   return 'Please enter some text';
                                // }
                                // return null;
                                // },
                                onSaved: (value) {
                                  code.text = value.toString();
                                },
                                // onChanged: (value) {
                                // _name.text = value.toString();
                                // },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Flexible(
                              child: DropdownButtonFormField<String>(
                                items: ['Foods', 'Goods', 'Others']
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      ),
                                    )
                                    .toList(),
                                value: genre.value,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(labelText: 'genre'),
                                onChanged: edit.value
                                    ? (value) => {genre.value = value}
                                    : null,
                                onSaved: (value) => {genre.value = value},
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        TextFormField(
                          enabled: edit.value,
                          controller: name,
                          // style: TextStyle(color: theme.appColors.onPrimary),
                          decoration: const InputDecoration(labelText: 'name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name.text = value.toString();
                          },
                          // onChanged: (value) {
                          // _name.text = value.toString();
                          // },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        TextFormField(
                          enabled: edit.value,
                          controller: desc,
                          maxLines: 2,
                          // style: TextStyle(color: theme.appColors.onPrimary),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'desc',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            desc.text = value.toString();
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                enabled: edit.value,
                                controller: stock,
                                // style:
                                // TextStyle(color: theme.appColors.onPrimary),
                                decoration:
                                    const InputDecoration(labelText: 'stock'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  stock.text = value.toString();
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Flexible(
                              child: TextFormField(
                                enabled: edit.value,
                                controller: price,
                                // style:
                                //     TextStyle(color: theme.appColors.onPrimary),
                                decoration:
                                    const InputDecoration(labelText: 'price'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  price.text = value.toString();
                                },
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                        ),
                        //
                        Row(
                          children: [
                            (order.value || edit.value == false)
                                ? const Text(
                                    '有効期間',
                                    // style: theme.textTheme.h30.copyWith(
                                    //     color: theme.appColors.onPrimary),
                                  )
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        // primary: theme.appColors.primary,
                                        // onPrimary: theme.appColors.onPrimary,
                                        ),
                                    child: const Text(
                                      '有効期間',
                                      // style: theme.textTheme.h30.copyWith(
                                      //     color: theme.appColors.onPrimary),
                                    ),
                                    onPressed: () async {
                                      final dateRange =
                                          await showDateRangePicker(
                                        context: context,
                                        initialDateRange: DateTimeRange(
                                            start: DateTime.now(),
                                            end: DateTime.now()),
                                        firstDate: DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day),
                                        lastDate:
                                            DateTime(DateTime.now().year + 3),
                                        builder: isDarkMode(context)
                                            ? null
                                            : (context, child) {
                                                return Theme(
                                                  data: theme.data.copyWith(
                                                    colorScheme: theme
                                                        .data.colorScheme
                                                        .copyWith(
                                                      surface: theme
                                                          .appColors.primary,
                                                    ),
                                                  ),
                                                  child: child as Widget,
                                                );
                                              },
                                      );
                                      if (dateRange != null) {
                                        expirationFrom.text = dateFormatter
                                            .format(dateRange.start);
                                        expirationTo.text =
                                            dateFormatter.format(dateRange.end);
                                      }
                                    },
                                  ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                            ),
                            Flexible(
                              child: TextFormField(
                                enabled: false,
                                controller: expirationFrom,
                                // style:
                                //     TextStyle(color: theme.appColors.onPrimary),
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: "From",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (DateTime.parse(value).isAfter(
                                      DateTime.parse(expirationTo.text))) {
                                    return 'Please enter a date after the specified date';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  expirationFrom.text = value.toString();
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                            ),
                            Flexible(
                              child: TextFormField(
                                enabled: false,
                                controller: expirationTo,
                                // style:
                                //     TextStyle(color: theme.appColors.onPrimary),
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: "To",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  expirationTo.text = value.toString();
                                },
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        Visibility(
                          visible: order.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('数量：', style: theme.textTheme.h30
                                  // .copyWith(color: theme.appColors.onPrimary),
                                  ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                              ),
                              DropdownButton<String>(
                                items: List.generate(
                                        int.parse(product.stock.toString()),
                                        (index) => 1 + index)
                                    .map(
                                      (quantity) => DropdownMenuItem<String>(
                                        value: quantity.toString(),
                                        child: Text(quantity.toString()),
                                      ),
                                    )
                                    .toList(),
                                value: quantity.value.toString(),
                                onChanged: (value) => {
                                  quantity.value = int.parse(value.toString())
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // primary: theme.appColors.primary,
                                    // onPrimary: theme.appColors.onPrimary,
                                    ),
                                onPressed: (product.stock != 0 &&
                                        isOpened &&
                                        verified.value)
                                    ? () async {
                                        // if(){};
                                        final isConfirmed = await showConfirmDialog(
                                            context,
                                            '${product.name} を購入しますか？\n数量 ${quantity.value}');
                                        // 購入処理
                                        if (isConfirmed) {
                                          try {
                                            // await model.createCharge(product);
                                            await viewModel.updateProduct(
                                                updateProduct: product.copyWith(
                                                    stock: (product.stock! -
                                                        quantity.value)));
                                            await ref
                                                .watch(orderViewModelProvider
                                                    .notifier)
                                                .addOrder(
                                                  userId: uid,
                                                  userName: userName,
                                                  organizer: product.organizer,
                                                  bazaarId: product.bazaarId,
                                                  bazaarName:
                                                      product.bazaarName,
                                                  code: product.code,
                                                  name: product.name,
                                                  desc: product.desc,
                                                  price: product.price as int,
                                                  quantity: quantity.value,
                                                  numberOfUse: quantity.value,
                                                  picture1URL:
                                                      product.picture1URL,
                                                  picture2URL:
                                                      product.picture2URL,
                                                  picture3URL:
                                                      product.picture3URL,
                                                  expirationFrom:
                                                      product.expirationFrom,
                                                  expirationTo:
                                                      product.expirationTo,
                                                );
                                            await showTextDialog(
                                                context, '購入しました');
                                            appRoute.pop();
                                          } catch (e) {
                                            await showTextDialog(
                                                context, e.toString());
                                          }
                                        }
                                      }
                                    : null,
                                child: const Text('購入する'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      error: (e, msg) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              e.toString(),
              style: theme.textTheme.h30,
            ),
          ),
        ),
      ),
      loading: () {
        return const Scaffold(
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                  // color: theme.appColors.primary,
                  ),
            ),
          ),
        );
      },
    );
  }
}

bool isDarkMode(BuildContext context) {
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  return brightness == Brightness.dark;
}
