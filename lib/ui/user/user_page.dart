// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../gen/assets.gen.dart';
// import '../../ui/hooks/use_l10n.dart';
// import '../../ui/theme/app_text_theme.dart';
// import '../../ui/theme/app_theme.dart';
// import 'user_view_model.dart';

// class UserPage extends HookConsumerWidget {
//   const UserPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(appThemeProvider);
//     final state = ref.watch(userViewModelProvider);
//     final viewModel = ref.watch(userViewModelProvider.notifier);
//     final l10n = useL10n();

//     return state.when(
//       data: (data) {
//         return Scaffold(
//           body: SafeArea(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Assets.img.flutterIcon.image(width: 200),
//                   Text(
//                     'hello',
//                     style: theme.textTheme.h70.bold(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       error: (e, msg) => Text(e.toString()),
//       loading: () {
//         return Scaffold(
//           body: SafeArea(
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: theme.appColors.primary,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
