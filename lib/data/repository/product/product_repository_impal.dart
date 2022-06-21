import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/product/product_model.dart';
import '../../model/result/result.dart';
import 'product_repository.dart';

final productRepositoryProvider =
    Provider<ProductRepository>((ref) => ProductRepositoryImpl(ref.read));

final productListStreamProvider = StreamProvider.autoDispose((ref) {
  CollectionReference ref = FirebaseFirestore.instance.collection('product');
  return ref.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Product.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  });
});

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._reader);
  final Reader _reader;

  final _db = FirebaseFirestore.instance;
  final _collectionPath = 'product';

  @override
  Future<Result<List<Product>>> readProduct() async {
    return Result.guardFuture(
      () async {
        final QuerySnapshot querySnapshot =
            await _db.collection(_collectionPath).get();
        final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
        return queryDocSnapshot.map((doc) {
          final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
          return Product.fromJson(map).copyWith(id: doc.id);
        }).toList();
      },
    );
  }

  @override
  Future<Result<String>> createProduct({required Product product}) async {
    return Result.guardFuture(
      () async {
        // アイテムを登録
        final docRef = await _db
            .collection(_collectionPath)
            .add(product.toJson()..remove('id'));
        await docRef.set({
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        return docRef.id;
      },
    );
  }

  @override
  Future<Result<void>> updateProduct({required Product product}) async {
    return Result.guardFuture(
      () async {
        // アイテムを更新
        _db.collection(_collectionPath).doc(product.id)
          ..update(product.toJson())
          ..set({
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
      },
    );
  }

  @override
  Future<Result<void>> deleteProduct({required productId}) async {
    return Result.guardFuture(
      () async {
        // アイテムを削除
        await _db.collection(_collectionPath).doc(productId).delete();
      },
    );
  }
}
