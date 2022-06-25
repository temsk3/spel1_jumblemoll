// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i24;
import 'package:jumblemoll/ui/account/account_page.dart' as _i2;
import 'package:jumblemoll/ui/auth/auth.dart' as _i1;
import 'package:jumblemoll/ui/bazaar/bazaar_add_page.dart' as _i13;
import 'package:jumblemoll/ui/bazaar/bazaar_details_page.dart' as _i11;
import 'package:jumblemoll/ui/bazaar/bazaar_edit_page.dart' as _i12;
import 'package:jumblemoll/ui/bazaar/bazaar_page.dart' as _i10;
import 'package:jumblemoll/ui/bazaar/supporter_page.dart' as _i18;
import 'package:jumblemoll/ui/common/image_crop.dart' as _i14;
import 'package:jumblemoll/ui/favorite/favorite_page.dart' as _i9;
import 'package:jumblemoll/ui/home.dart' as _i3;
import 'package:jumblemoll/ui/order/order_page.dart' as _i6;
import 'package:jumblemoll/ui/order/product_status_page.dart' as _i8;
import 'package:jumblemoll/ui/order/purchase_page.dart' as _i5;
import 'package:jumblemoll/ui/order/sales_status_page.dart' as _i7;
import 'package:jumblemoll/ui/product/product_add_page.dart' as _i17;
import 'package:jumblemoll/ui/product/product_details_page.dart' as _i15;
import 'package:jumblemoll/ui/product/product_edit_page.dart' as _i16;
import 'package:jumblemoll/ui/product/product_list_all.dart' as _i20;
import 'package:jumblemoll/ui/product/product_list_foods.dart' as _i21;
import 'package:jumblemoll/ui/product/product_list_goods.dart' as _i22;
import 'package:jumblemoll/ui/product/product_list_others.dart' as _i23;
import 'package:jumblemoll/ui/product/product_page.dart' as _i19;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i24.GlobalKey<_i24.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i1.AuthPage(),
          fullscreenDialog: true);
    },
    AccountRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.AccountPage(),
          fullscreenDialog: true);
    },
    HomeRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    BazaarListRouter.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProductRouter.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    PurchaseRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.PurchasePage());
    },
    OrderRoute.name: (routeData) {
      final args = routeData.argsAs<OrderRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.OrderPage(key: args.key, bazaar: args.bazaar));
    },
    SalesStatusRoute.name: (routeData) {
      final args = routeData.argsAs<SalesStatusRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.SalesStatusPage(key: args.key, bazaar: args.bazaar));
    },
    ProductStatusRoute.name: (routeData) {
      final args = routeData.argsAs<ProductStatusRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.ProductStatusPage(key: args.key, bazaar: args.bazaar));
    },
    FavoriteRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i9.FavoritePage());
    },
    BazaarListRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i10.BazaarListPage());
    },
    BazaarDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BazaarDetailsRouteArgs>(
          orElse: () =>
              BazaarDetailsRouteArgs(index: pathParams.getInt('index')));
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i11.BazaarDetailsPage(
              key: args.key, index: args.index, bazaarEvent: args.bazaarEvent));
    },
    BazaarEditRoute.name: (routeData) {
      final args = routeData.argsAs<BazaarEditRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i12.BazaarEditPage(key: args.key, index: args.index));
    },
    BazaarAddRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i13.BazaarAddPage());
    },
    ImageCropRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i14.ImageCropPage());
    },
    ProductDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailsRouteArgs>(
          orElse: () => ProductDetailsRouteArgs(
              index: pathParams.get('index'),
              bazaarEvent: pathParams.get('bazaar'),
              productItem: pathParams.get('product')));
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i15.ProductDetailsPage(
              key: args.key,
              index: args.index,
              bazaarEvent: args.bazaarEvent,
              productItem: args.productItem));
    },
    ProductEditRoute.name: (routeData) {
      final args = routeData.argsAs<ProductEditRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i16.ProductEditPage(key: args.key, index: args.index));
    },
    ProductAddRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductAddRouteArgs>(
          orElse: () => ProductAddRouteArgs(bazaar: pathParams.get('bazaar')));
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i17.ProductAddPage(key: args.key, bazaar: args.bazaar));
    },
    SupporterRoute.name: (routeData) {
      final args = routeData.argsAs<SupporterRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i18.SupporterPage(key: args.key, bazaarId: args.bazaarId));
    },
    ProductRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i19.ProductPage());
    },
    ProductAllRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i20.ProductAllPage());
    },
    ProductFoodsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i21.ProductFoodsPage());
    },
    ProductGoodsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i22.ProductGoodsPage());
    },
    ProductOthersRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i23.ProductOthersPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(AuthRoute.name, path: 'auth'),
        _i4.RouteConfig(AccountRoute.name, path: 'account'),
        _i4.RouteConfig(HomeRoute.name, path: '/', children: [
          _i4.RouteConfig(BazaarListRouter.name,
              path: 'bazaar',
              parent: HomeRoute.name,
              children: [
                _i4.RouteConfig(BazaarListRoute.name,
                    path: '', parent: BazaarListRouter.name),
                _i4.RouteConfig('*#redirect',
                    path: '*',
                    parent: BazaarListRouter.name,
                    redirectTo: '',
                    fullMatch: true),
                _i4.RouteConfig(BazaarDetailsRoute.name,
                    path: ':bazaarId', parent: BazaarListRouter.name),
                _i4.RouteConfig(BazaarEditRoute.name,
                    path: 'bazaarEdit', parent: BazaarListRouter.name),
                _i4.RouteConfig(BazaarAddRoute.name,
                    path: 'bazaarAdd', parent: BazaarListRouter.name),
                _i4.RouteConfig(ImageCropRoute.name,
                    path: 'crop', parent: BazaarListRouter.name),
                _i4.RouteConfig(ProductDetailsRoute.name,
                    path: ':productId', parent: BazaarListRouter.name),
                _i4.RouteConfig(ProductEditRoute.name,
                    path: 'productEdit', parent: BazaarListRouter.name),
                _i4.RouteConfig(ProductAddRoute.name,
                    path: 'productAdd', parent: BazaarListRouter.name),
                _i4.RouteConfig(SupporterRoute.name,
                    path: 'bazaarSupport', parent: BazaarListRouter.name),
                _i4.RouteConfig(OrderRoute.name,
                    path: 'order', parent: BazaarListRouter.name),
                _i4.RouteConfig(SalesStatusRoute.name,
                    path: 'salesStatus', parent: BazaarListRouter.name),
                _i4.RouteConfig(ProductStatusRoute.name,
                    path: 'productStatus', parent: BazaarListRouter.name)
              ]),
          _i4.RouteConfig(ProductRouter.name,
              path: 'product',
              parent: HomeRoute.name,
              children: [
                _i4.RouteConfig('*#redirect',
                    path: '*',
                    parent: ProductRouter.name,
                    redirectTo: '',
                    fullMatch: true),
                _i4.RouteConfig(ProductRoute.name,
                    path: '',
                    parent: ProductRouter.name,
                    children: [
                      _i4.RouteConfig(ProductAllRoute.name,
                          path: 'productAll', parent: ProductRoute.name),
                      _i4.RouteConfig(ProductFoodsRoute.name,
                          path: 'productFoods', parent: ProductRoute.name),
                      _i4.RouteConfig(ProductGoodsRoute.name,
                          path: 'productGoods', parent: ProductRoute.name),
                      _i4.RouteConfig(ProductOthersRoute.name,
                          path: 'productOthers', parent: ProductRoute.name)
                    ]),
                _i4.RouteConfig(ProductDetailsRoute.name,
                    path: ':productId', parent: ProductRouter.name),
                _i4.RouteConfig(ProductEditRoute.name,
                    path: 'productEdit', parent: ProductRouter.name),
                _i4.RouteConfig(ProductAddRoute.name,
                    path: 'productAdd', parent: ProductRouter.name)
              ]),
          _i4.RouteConfig(PurchaseRoute.name,
              path: 'purchase', parent: HomeRoute.name),
          _i4.RouteConfig(OrderRoute.name,
              path: 'order', parent: HomeRoute.name),
          _i4.RouteConfig(SalesStatusRoute.name,
              path: 'salesStatus', parent: HomeRoute.name),
          _i4.RouteConfig(ProductStatusRoute.name,
              path: 'productStatus', parent: HomeRoute.name),
          _i4.RouteConfig(FavoriteRoute.name,
              path: 'favorite', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i4.PageRouteInfo<void> {
  const AuthRoute() : super(AuthRoute.name, path: 'auth');

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i2.AccountPage]
class AccountRoute extends _i4.PageRouteInfo<void> {
  const AccountRoute() : super(AccountRoute.name, path: 'account');

  static const String name = 'AccountRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class BazaarListRouter extends _i4.PageRouteInfo<void> {
  const BazaarListRouter({List<_i4.PageRouteInfo>? children})
      : super(BazaarListRouter.name, path: 'bazaar', initialChildren: children);

  static const String name = 'BazaarListRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ProductRouter extends _i4.PageRouteInfo<void> {
  const ProductRouter({List<_i4.PageRouteInfo>? children})
      : super(ProductRouter.name, path: 'product', initialChildren: children);

  static const String name = 'ProductRouter';
}

/// generated route for
/// [_i5.PurchasePage]
class PurchaseRoute extends _i4.PageRouteInfo<void> {
  const PurchaseRoute() : super(PurchaseRoute.name, path: 'purchase');

  static const String name = 'PurchaseRoute';
}

/// generated route for
/// [_i6.OrderPage]
class OrderRoute extends _i4.PageRouteInfo<OrderRouteArgs> {
  OrderRoute({_i24.Key? key, required String? bazaar})
      : super(OrderRoute.name,
            path: 'order', args: OrderRouteArgs(key: key, bazaar: bazaar));

  static const String name = 'OrderRoute';
}

class OrderRouteArgs {
  const OrderRouteArgs({this.key, required this.bazaar});

  final _i24.Key? key;

  final String? bazaar;

  @override
  String toString() {
    return 'OrderRouteArgs{key: $key, bazaar: $bazaar}';
  }
}

/// generated route for
/// [_i7.SalesStatusPage]
class SalesStatusRoute extends _i4.PageRouteInfo<SalesStatusRouteArgs> {
  SalesStatusRoute({_i24.Key? key, required dynamic bazaar})
      : super(SalesStatusRoute.name,
            path: 'salesStatus',
            args: SalesStatusRouteArgs(key: key, bazaar: bazaar));

  static const String name = 'SalesStatusRoute';
}

class SalesStatusRouteArgs {
  const SalesStatusRouteArgs({this.key, required this.bazaar});

  final _i24.Key? key;

  final dynamic bazaar;

  @override
  String toString() {
    return 'SalesStatusRouteArgs{key: $key, bazaar: $bazaar}';
  }
}

/// generated route for
/// [_i8.ProductStatusPage]
class ProductStatusRoute extends _i4.PageRouteInfo<ProductStatusRouteArgs> {
  ProductStatusRoute({_i24.Key? key, required dynamic bazaar})
      : super(ProductStatusRoute.name,
            path: 'productStatus',
            args: ProductStatusRouteArgs(key: key, bazaar: bazaar));

  static const String name = 'ProductStatusRoute';
}

class ProductStatusRouteArgs {
  const ProductStatusRouteArgs({this.key, required this.bazaar});

  final _i24.Key? key;

  final dynamic bazaar;

  @override
  String toString() {
    return 'ProductStatusRouteArgs{key: $key, bazaar: $bazaar}';
  }
}

/// generated route for
/// [_i9.FavoritePage]
class FavoriteRoute extends _i4.PageRouteInfo<void> {
  const FavoriteRoute() : super(FavoriteRoute.name, path: 'favorite');

  static const String name = 'FavoriteRoute';
}

/// generated route for
/// [_i10.BazaarListPage]
class BazaarListRoute extends _i4.PageRouteInfo<void> {
  const BazaarListRoute() : super(BazaarListRoute.name, path: '');

  static const String name = 'BazaarListRoute';
}

/// generated route for
/// [_i11.BazaarDetailsPage]
class BazaarDetailsRoute extends _i4.PageRouteInfo<BazaarDetailsRouteArgs> {
  BazaarDetailsRoute({_i24.Key? key, required int index, dynamic bazaarEvent})
      : super(BazaarDetailsRoute.name,
            path: ':bazaarId',
            args: BazaarDetailsRouteArgs(
                key: key, index: index, bazaarEvent: bazaarEvent),
            rawPathParams: {'index': index});

  static const String name = 'BazaarDetailsRoute';
}

class BazaarDetailsRouteArgs {
  const BazaarDetailsRouteArgs(
      {this.key, required this.index, this.bazaarEvent});

  final _i24.Key? key;

  final int index;

  final dynamic bazaarEvent;

  @override
  String toString() {
    return 'BazaarDetailsRouteArgs{key: $key, index: $index, bazaarEvent: $bazaarEvent}';
  }
}

/// generated route for
/// [_i12.BazaarEditPage]
class BazaarEditRoute extends _i4.PageRouteInfo<BazaarEditRouteArgs> {
  BazaarEditRoute({_i24.Key? key, required int index})
      : super(BazaarEditRoute.name,
            path: 'bazaarEdit',
            args: BazaarEditRouteArgs(key: key, index: index));

  static const String name = 'BazaarEditRoute';
}

class BazaarEditRouteArgs {
  const BazaarEditRouteArgs({this.key, required this.index});

  final _i24.Key? key;

  final int index;

  @override
  String toString() {
    return 'BazaarEditRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i13.BazaarAddPage]
class BazaarAddRoute extends _i4.PageRouteInfo<void> {
  const BazaarAddRoute() : super(BazaarAddRoute.name, path: 'bazaarAdd');

  static const String name = 'BazaarAddRoute';
}

/// generated route for
/// [_i14.ImageCropPage]
class ImageCropRoute extends _i4.PageRouteInfo<void> {
  const ImageCropRoute() : super(ImageCropRoute.name, path: 'crop');

  static const String name = 'ImageCropRoute';
}

/// generated route for
/// [_i15.ProductDetailsPage]
class ProductDetailsRoute extends _i4.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute(
      {_i24.Key? key, dynamic index, dynamic bazaarEvent, dynamic productItem})
      : super(ProductDetailsRoute.name,
            path: ':productId',
            args: ProductDetailsRouteArgs(
                key: key,
                index: index,
                bazaarEvent: bazaarEvent,
                productItem: productItem),
            rawPathParams: {
              'index': index,
              'bazaar': bazaarEvent,
              'product': productItem
            });

  static const String name = 'ProductDetailsRoute';
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs(
      {this.key, this.index, this.bazaarEvent, this.productItem});

  final _i24.Key? key;

  final dynamic index;

  final dynamic bazaarEvent;

  final dynamic productItem;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, index: $index, bazaarEvent: $bazaarEvent, productItem: $productItem}';
  }
}

/// generated route for
/// [_i16.ProductEditPage]
class ProductEditRoute extends _i4.PageRouteInfo<ProductEditRouteArgs> {
  ProductEditRoute({_i24.Key? key, required int index})
      : super(ProductEditRoute.name,
            path: 'productEdit',
            args: ProductEditRouteArgs(key: key, index: index));

  static const String name = 'ProductEditRoute';
}

class ProductEditRouteArgs {
  const ProductEditRouteArgs({this.key, required this.index});

  final _i24.Key? key;

  final int index;

  @override
  String toString() {
    return 'ProductEditRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i17.ProductAddPage]
class ProductAddRoute extends _i4.PageRouteInfo<ProductAddRouteArgs> {
  ProductAddRoute({_i24.Key? key, dynamic bazaar})
      : super(ProductAddRoute.name,
            path: 'productAdd',
            args: ProductAddRouteArgs(key: key, bazaar: bazaar),
            rawPathParams: {'bazaar': bazaar});

  static const String name = 'ProductAddRoute';
}

class ProductAddRouteArgs {
  const ProductAddRouteArgs({this.key, this.bazaar});

  final _i24.Key? key;

  final dynamic bazaar;

  @override
  String toString() {
    return 'ProductAddRouteArgs{key: $key, bazaar: $bazaar}';
  }
}

/// generated route for
/// [_i18.SupporterPage]
class SupporterRoute extends _i4.PageRouteInfo<SupporterRouteArgs> {
  SupporterRoute({_i24.Key? key, required dynamic bazaarId})
      : super(SupporterRoute.name,
            path: 'bazaarSupport',
            args: SupporterRouteArgs(key: key, bazaarId: bazaarId));

  static const String name = 'SupporterRoute';
}

class SupporterRouteArgs {
  const SupporterRouteArgs({this.key, required this.bazaarId});

  final _i24.Key? key;

  final dynamic bazaarId;

  @override
  String toString() {
    return 'SupporterRouteArgs{key: $key, bazaarId: $bazaarId}';
  }
}

/// generated route for
/// [_i19.ProductPage]
class ProductRoute extends _i4.PageRouteInfo<void> {
  const ProductRoute({List<_i4.PageRouteInfo>? children})
      : super(ProductRoute.name, path: '', initialChildren: children);

  static const String name = 'ProductRoute';
}

/// generated route for
/// [_i20.ProductAllPage]
class ProductAllRoute extends _i4.PageRouteInfo<void> {
  const ProductAllRoute() : super(ProductAllRoute.name, path: 'productAll');

  static const String name = 'ProductAllRoute';
}

/// generated route for
/// [_i21.ProductFoodsPage]
class ProductFoodsRoute extends _i4.PageRouteInfo<void> {
  const ProductFoodsRoute()
      : super(ProductFoodsRoute.name, path: 'productFoods');

  static const String name = 'ProductFoodsRoute';
}

/// generated route for
/// [_i22.ProductGoodsPage]
class ProductGoodsRoute extends _i4.PageRouteInfo<void> {
  const ProductGoodsRoute()
      : super(ProductGoodsRoute.name, path: 'productGoods');

  static const String name = 'ProductGoodsRoute';
}

/// generated route for
/// [_i23.ProductOthersPage]
class ProductOthersRoute extends _i4.PageRouteInfo<void> {
  const ProductOthersRoute()
      : super(ProductOthersRoute.name, path: 'productOthers');

  static const String name = 'ProductOthersRoute';
}
