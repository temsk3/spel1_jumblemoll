import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/result/result.dart';
import '../../../model/transaction/purchase/order_model.dart';
import '../../general_provider.dart';
import 'order_repository.dart';

final orderRepositoryProvider =
    Provider<OrderRepository>((ref) => OrderRepositoryImpl(ref.read));

final orderListStreamProvider = StreamProvider.autoDispose((ref) {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('orders');
  final list = collectionRef.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Order.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  });
  return list;
});
final orderStreamProvider =
    StreamProvider.autoDispose.family<List<Order>, String>((ref, id) {
  return FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: id)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return Order.fromJson(doc.data()).copyWith(id: doc.id);
    }).toList();
  });
});
// final orderGroupByStreamProvider =
//     StreamProvider.autoDispose.family<List<Order>, String>((ref, bazaarId) async* {
//   // final list = FirebaseFirestore.instance
//   //     .collection('orders')
//   //     .where('bazaarId', isEqualTo: bazaarId)
//   //     .snapshots()
//   //     .map((snapshot) {
//   //   return snapshot.docs.map((doc) {
//   //     return Order.fromJson(doc.data()).copyWith(id: doc.id);
//   //   }).toList();
//   // });
//   //
//   final QuerySnapshot querySnapshot = await
//              FirebaseFirestore.instance
//                 .collection('orders')
//       .where('bazaarId', isEqualTo: bazaarId)
//                 .get();
//         final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
//         final orderModelList = queryDocSnapshot.map((doc) {
//           final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
//           return Order.fromJson(map).copyWith(id: doc.id);
//         }).toList();

//   // List<MapEntry<String, List<Order>>> getMapEntrysGroupByName(
//   //     List<Order> orderModelList) {
//   //   //ListをGroupByしたMapにする。
//     Map<String, List<Order>> _groupByNameMap =
//         _makeGroupByNameMap(orderModelList);

//   //   //MapEntry化してListに格納する。
//   //   List<MapEntry<String, List<Order>>> _listPerName =
//   //       _makeMapEntryListPerName(_groupByNameMap);

//   //   return _listPerName;
//   // }
//   yield _groupByNameMap;
// });
// //
//   Map<String, List<Order>> _makeGroupByNameMap(
//       List<Order> orderModelList) {
//     Map<String, List<Order>> _groupByNameMap = {};

//     for (Order orderModel in orderModelList) {
//       //ループしてきたuserModelのageでまだグループ化してない場合は先に空配列を代入する。
//       _groupByNameMap[orderModel.name!] ??= [];
//       _groupByNameMap[orderModel.name]!.add(orderModel);
//     }
//     return _groupByNameMap;
//   }
//   List<MapEntry<String, List<Order>>> _makeMapEntryListPerName(
//       Map<String, List<Order>> _groupByNameMap) {
//     List<MapEntry<String, List<Order>>> _listPerAge = [];

//     _groupByNameMap.forEach((key, value) {
//       _listPerAge.add(MapEntry(key, value));
//     });

//     return _listPerAge;
//   }
class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._reader);
  final Reader _reader;

  // final _db = FirebaseFirestore.instance;
  final _collectionPath = 'orders';

  @override
  Future<Result<List<Order>>> readOrder() async {
    return Result.guardFuture(
      () async {
        final QuerySnapshot querySnapshot =
            await _reader(firebaseFirestoreProvider)
                .collection(_collectionPath)
                .get();
        final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
        final orderList = queryDocSnapshot.map((doc) {
          final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
          return Order.fromJson(map).copyWith(id: doc.id);
        }).toList();
        return orderList;
      },
    );
  }

  @override
  Future<Result<String>> createOrder({required Order order}) async {
    return Result.guardFuture(
      () async {
        // 購入商品の登録
        final docRef = await _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .add(order.toJson()..remove('id'));
        await docRef.set({
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        return docRef.id;
      },
    );
  }

  @override
  Future<Result<void>> updateOrder({required Order order}) async {
    return Result.guardFuture(
      () async {
        _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(order.id)
          ..update(order.toJson())
          ..set({
            // 'numberOfUse': FieldValue.increment(-1),
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        // // アイテムを更新
        // if ((order.numberOfUse) == 0) {
        //   _db.collection(_collectionPath).doc(order.id)
        //     ..update(order.toJson())
        //     ..set({
        //       'isActive': false,
        //       'updatedAt': FieldValue.serverTimestamp(),
        //     }, SetOptions(merge: true));
        // } else {
        //   _db.collection(_collectionPath).doc(order.id)
        //     ..update(order.toJson())
        //     ..set({
        //       'numberOfUse': FieldValue.increment(-1),
        //       'updatedAt': FieldValue.serverTimestamp(),
        //     }, SetOptions(merge: true));
        // }
      },
    );
  }

  @override
  Future<Result<void>> deleteOrder({required orderId}) async {
    return Result.guardFuture(
      () async {
        // アイテムを削除
        await _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(orderId)
            .delete();
      },
    );
  }
}
