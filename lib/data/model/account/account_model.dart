import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

import '../../repository/user/user_repository.dart';
import '../user/user_model.dart';

class AccountModel extends ChangeNotifier {
  bool isLoading = false;
  User? user;

  final userRepo = UserRepository();

  Future<void> init() async {
    user = await userRepo.fetch();
    notifyListeners();
  }

  Future<void> signOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
