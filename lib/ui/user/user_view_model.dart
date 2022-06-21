// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../data/repository/user/user_repository.dart';
// import '../../data/repository/user/user_repository_impal.dart';
// import 'user_state.dart';

// final userViewModelProvider =
//     StateNotifierProvider.autoDispose<UserViewModel, AsyncValue<UserState>>(
//   (ref) => UserViewModel(ref: ref),
// );

// class UserViewModel extends StateNotifier<AsyncValue<UseårState>> {
//   final AutoDisposeStateNotifierProviderRef _ref;
//   UserViewModel({required AutoDisposeStateNotifierProviderRef ref})
//       : _ref = ref,
//         super(const AsyncLoading()) {
//     readUser();
//   }

//   // repository
//   late final UserRepository userRepository = _ref.read(userRepositoryProvider);

//   // 取得
//   Future<void> readUser() async {
//     final result = await userRepository.readUser();
//     result.when(
//       success: (data) {
//         state = AsyncValue.data(
//           UserState(userList: data),
//         );
//       },
//       failure: (error) {
//         state = AsyncValue.error(error);
//       },
//     );
//   }

//   // // 追加
//   // Future<void> addBazaarEvent({
//   //   required String organizer,
//   //   required String name,
//   // }) async {
//   //   final bazaarEvent = User(
//   //     organizer: organizer,
//   //     name: name,
//   //   );
//   //   final eventId =
//   //       await bazaarEventRepository.createBazaarEvent(event: bazaarEvent);
//   //   eventId.when(
//   //     success: (data) {
//   //       final eventList = state.value!.eventList;
//   //       state = AsyncValue.data(
//   //         BazaarEventState(
//   //           eventList: eventList
//   //             ..add(
//   //               bazaarEvent.copyWith(id: data),
//   //             ),
//   //         ),
//   //       );
//   //     },
//   //     failure: (error) {
//   //       state = AsyncValue.error(error);
//   //     },
//   //   );
//   // }

//   // // 更新
//   // Future<void> updateBazaarEvent(
//   //     {required BazaarEvent updateBazaarEvent}) async {
//   //   final result =
//   //       await bazaarEventRepository.updateBazaarEvent(event: updateBazaarEvent);
//   //   result.when(
//   //     success: (data) {
//   //       final bazaarEvents = state.value!.eventList;
//   //       state = AsyncValue.data(
//   //         BazaarEventState(
//   //           eventList: [
//   //             for (final bazaarEvent in bazaarEvents)
//   //               if (bazaarEvent.id == updateBazaarEvent.id)
//   //                 updateBazaarEvent
//   //               else
//   //                 bazaarEvent
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //     failure: (error) {
//   //       state = AsyncValue.error(error);
//   //     },
//   //   );
//   // }

//   // //削除
//   // Future<void> deleteBazaarEvent({required String eventId}) async {
//   //   final result =
//   //       await bazaarEventRepository.deleteBazaarEvent(eventId: eventId);
//   //   result.when(
//   //     success: (data) {
//   //       final eventList = state.value!.eventList;
//   //       state = AsyncValue.data(
//   //         BazaarEventState(
//   //           eventList: eventList
//   //             ..removeWhere((bazaarEvent) => bazaarEvent.id == eventId),
//   //         ),
//   //       );
//   //     },
//   //     failure: (error) {
//   //       state = AsyncValue.error(error);
//   //     },
//   //   );
//   // }
// }
