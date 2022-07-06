import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jumblemoll/data/repository/stripe/stripe_repository.dart';
import 'package:logger/logger.dart';

import '../../../ui/account/account_view_model.dart';
import '../../../ui/account/stripe_view_model.dart';

final logger = Logger();

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  //  All these functions are async because this involves a future.
  //  if async keyword is not used, it will throw an error.
  //  to know more about futures, check out the documentation.
  //  https://dart.dev/codelabs/async-await
  //  Read this to know more about futures.
  //  Trust me it will really clear all your concepts about futures

  //  SigIn the user using Email and Password
  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    final localizations = MaterialLocalizations.of(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(localizations.okButtonLabel))
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(String email, String password,
      BuildContext context, WidgetRef ref) async {
    final localizations = MaterialLocalizations.of(context);
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (credential) async {
          logger.d(credential.user!.uid);
          final customerId =
              await ref.read(stripeRepositoryProvider).createCustomer(email);
          logger.d(customerId);

          final accountId = await ref
              .read(stripeRepositoryProvider)
              .createConnectAccount(email);
          logger.d(accountId);

          await ref.watch(userViewModelProvider.notifier).createUser(
                credential.user,
                customerId,
                accountId,
              );
        },
      ).catchError((e) => logger.e(e));
      // UserCredential result = await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // // user ドキュメントがあるか確認
      // User? user = result.user;
      // final userId = user!.uid;
      // final doc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .get();

      // // user ドキュメントがない場合は作成
      // if (!doc.exists) {
      //   /// Stripe の customer（お金を払う側のアカウント）を作成
      //   final customerId = await ref
      //       .watch(stripeViewModelProvider.notifier)
      //       .createCustomer(email);

      //   /// Stripe の connectAccount (お金を受け取る側のアカウント）を作成
      //   final accountId = await ref
      //       .watch(stripeViewModelProvider.notifier)
      //       .createConnectAccount(email);

      //   // user ドキュメントを作成
      //   await ref.watch(userViewModelProvider.notifier).createUser(
      //         user,
      //         customerId,
      //         accountId,
      //       );
      // }
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text(localizations.okButtonLabel))
                  ]));
    } catch (e) {
      logger.e(e);
      if (e == 'email-already-in-use') {
        // print('Email already in use.');
      } else {
        // print('Error: $e');
      }
    }
  }

  //  SignIn the user Google
  Future<void> signInWithGoogle(BuildContext context, WidgetRef ref) async {
    final localizations = MaterialLocalizations.of(context);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential1 = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final credential = await _auth.signInWithCredential(credential1);
      // user ドキュメントがあるか確認
      final userId = credential.user?.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // user ドキュメントがない場合は作成
      if (!doc.exists) {
        /// Stripe の customer（お金を払う側のアカウント）を作成
        final customerId = await ref
            .watch(stripeViewModelProvider.notifier)
            .createCustomer(credential.user?.email ?? '');

        /// Stripe の connectAccount (お金を受け取る側のアカウント）を作成
        final accountId = await ref
            .watch(stripeViewModelProvider.notifier)
            .createConnectAccount(credential.user?.email ?? '');

        // user ドキュメントを作成
        await ref.watch(userViewModelProvider.notifier).createUser(
              credential.user,
              customerId,
              accountId,
            );
      }
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occurred'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(localizations.okButtonLabel))
          ],
        ),
      );
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
