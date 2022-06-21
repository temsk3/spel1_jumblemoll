import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './auth_checker.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class AuthPage extends ConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    // return const AuthChecker();
    return initialize.when(
      data: (data) {
        return const AuthChecker();
      },
      loading: () => const LoadingScreen(),
      error: (e, stackTrace) => ErrorScreen(e, stackTrace),
    );
  }
}
