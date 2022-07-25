import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/bazaar/bazaar_model.dart';
import '../../model/bazaar/supporter_model.dart';
import '../../model/result/result.dart';
import '../general_provider.dart';
import 'bazaar_repository.dart';

const _collectionPath = 'events';
const _subCollectionPath = 'supporter';

final bazaarRepositoryProvider =
    Provider<BazaarRepository>((ref) => BazaarRepositoryImpl(ref.read));

final bazaarListStreamProvider = StreamProvider.autoDispose((ref) {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection(_collectionPath);
  final list = collectionRef.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Bazaar.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(id: doc.id);
    }).toList();
  });
  return list;
});

final supporterListStreamProvider =
    StreamProvider.autoDispose.family<List<Supporter>, String>((ref, bazaarId) {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('events/$bazaarId/supporter');
  final list = collectionRef.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Supporter.fromJson(doc.data() as Map<String, dynamic>)
          .copyWith(uid: doc.id);
    }).toList();
  });
  return list;
});

class BazaarRepositoryImpl implements BazaarRepository {
  BazaarRepositoryImpl(this._reader);
  final Reader _reader;

  // final _db = FirebaseFirestore.instance;

  @override
  Future<Result<List<Bazaar>>> readBazaar() async {
    return Result.guardFuture(
      () async {
        // アイテムを取得
        // final CollectionReference collectionRef =
        //     _db.collection(_collectionPath);
        // final QuerySnapshot querySnapshot = await collectionRef.get();
        final QuerySnapshot querySnapshot =
            await _reader(firebaseFirestoreProvider)
                .collection(_collectionPath)
                .get();
        final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
        return queryDocSnapshot.map((doc) {
          final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
          return Bazaar.fromJson(map).copyWith(id: doc.id);
        }).toList();

        // final CollectionReference bazaarRef = collectionRef.withConverter<Bazaar>(
        //       fromFirestore: (snap, _) => Bazaar.fromJson(snap.data()!),
        //       toFirestore: (bazaarbazaar, _) => bazaarbazaar.toJson(),
        //     );
        // final snap = await bazaarRef.get();
        // return snap.docs.map((doc) => doc.data()).toList();
      },
    );
  }

  @override
  Future<Result<String>> createBazaar({required Bazaar bazaar}) async {
    return Result.guardFuture(
      () async {
        // 登録
        final docRef = await _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .add(bazaar.toJson()..remove('id'));
        await docRef.set({
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        return docRef.id;
      },
    );
  }

  @override
  Future<Result<void>> updateBazaar({required Bazaar bazaar}) async {
    return Result.guardFuture(
      () async {
        // アイテムを更新
        _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(bazaar.id)
          ..update(bazaar.toJson())
          ..set({
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
      },
    );
  }

  @override
  Future<Result<void>> deleteBazaar({required bazaarId}) async {
    return Result.guardFuture(
      () async {
        // アイテムを削除
        await _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(bazaarId)
            .delete();
      },
    );
  }

  //
  @override
  Future<Result<List<Supporter>>> readSupporters(
      {required String bazaarId}) async {
    return Result.guardFuture(
      () async {
        // アイテムを取得
        final QuerySnapshot querySnapshot =
            await _reader(firebaseFirestoreProvider)
                .collection(_collectionPath)
                .doc(bazaarId)
                .collection(_subCollectionPath)
                .get();
        final List<QueryDocumentSnapshot> queryDocSnapshot = querySnapshot.docs;
        return queryDocSnapshot.map((doc) {
          final Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
          return Supporter.fromJson(map).copyWith(uid: doc.id);
        }).toList();
      },
    );
  }

  @override
  Future<Result<void>> createSupporter(
      {required String bazaarId, required Supporter supporter}) async {
    return Result.guardFuture(
      () async {
        final docRef = _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(bazaarId)
            .collection(_subCollectionPath)
            .doc(supporter.uid);

        final doc = await docRef.get();

        if (!doc.exists) {
          docRef
            ..set(supporter.toJson())
            ..set({
              'name': supporter.name,
              'isActive': supporter.isActive,
              'createdAt': FieldValue.serverTimestamp(),
              'updatedAt': FieldValue.serverTimestamp(),
            }, SetOptions(merge: true));
        }
      },
    );
  }

  @override
  Future<Result<void>> updateSupporter(
      {required String bazaarId, required Supporter supporter}) async {
    return Result.guardFuture(
      () async {
        // アイテムを更新
        final docRef = _reader(firebaseFirestoreProvider)
            .collection(_collectionPath)
            .doc(bazaarId.toString())
            .collection(_subCollectionPath)
            .doc(supporter.uid);
        // ..update(supporter.toJson())
        await docRef.set({
          'isActive': supporter.isActive,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      },
    );
  }
}
