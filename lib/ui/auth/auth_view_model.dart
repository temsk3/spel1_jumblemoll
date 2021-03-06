import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jumblemoll/data/repository/stripe/stripe_repository.dart';
import 'package:logger/logger.dart';

import '../../data/repository/user/user_repository.dart';
import '../account/account_view_model.dart';

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
    String email,
    String password,
    BuildContext context,
  ) async {
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
  Future<void> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final localizations = MaterialLocalizations.of(context);
    final stripe = ref.watch(stripeRepositoryProvider);
    final userViewModel = ref.watch(userRepositoryProvider);
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (credential) async {
          logger.d('SignUp');

          final accountId = await stripe.createConnectAccount(email);
          logger.d(accountId);

          final customerId = await stripe.createCustomer(email);
          logger.d(customerId);

          // const accountId = 'test';
          // const customerId = 'test';
          await userViewModel.createUser(
            credential.user,
            customerId,
            accountId,
            name,
          );
        },
      );
      // UserCredential result = await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // // user ????????????????????????????????????
      // User? user = result.user;
      // final userId = user!.uid;
      // final doc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .get();

      // // user ??????????????????????????????????????????
      // if (!doc.exists) {
      //   /// Stripe ??? customer???????????????????????????????????????????????????
      //   final customerId = await ref
      //       .watch(stripeViewModelProvider.notifier)
      //       .createCustomer(email);

      //   /// Stripe ??? connectAccount (??????????????????????????????????????????????????????
      //   final accountId = await ref
      //       .watch(stripeViewModelProvider.notifier)
      //       .createConnectAccount(email);

      //   // user ???????????????????????????
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
  Future<void> signInWithGoogle(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final localizations = MaterialLocalizations.of(context);
    final stripe = ref.watch(stripeRepositoryProvider);
    final userViewModel = ref.watch(userViewModelProvider.notifier);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        await _auth.signInWithPopup(authProvider).then(
          (credential) async {
            final email = credential.user!.email.toString();

            logger.d('SignUp');

            final accountId = await stripe.createConnectAccount(email);
            logger.d(accountId);

            final customerId = await stripe.createCustomer(email);
            logger.d(customerId);

            final name = credential.user!.displayName ?? '';

            await userViewModel.createUser(
              credential.user,
              customerId,
              accountId,
              name,
            );
          },
        );
      } catch (e) {
        logger.d(e);
      }
    } else {
      try {
        await _auth.signInWithCredential(credential).then(
          (credential) async {
            final email = credential.user!.email.toString();

            logger.d('SignUp');

            final accountId = await stripe.createConnectAccount(email);
            logger.d(accountId);

            final customerId = await stripe.createCustomer(email);
            logger.d(customerId);

            final name = credential.user!.displayName ?? '';

            await userViewModel.createUser(
              credential.user,
              customerId,
              accountId,
              name,
            );
          },
        );

        // final credential = await _auth.signInWithCredential(credential1);
        // // user ????????????????????????????????????
        // final userId = credential.user?.uid;
        // final doc = await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userId)
        //     .get();

        // // user ??????????????????????????????????????????
        // if (!doc.exists) {
        //   /// Stripe ??? customer???????????????????????????????????????????????????
        //   final customerId = await ref
        //       .watch(stripeViewModelProvider.notifier)
        //       .createCustomer(credential.user?.email ?? '');

        //   /// Stripe ??? connectAccount (??????????????????????????????????????????????????????
        //   final accountId = await ref
        //       .watch(stripeViewModelProvider.notifier)
        //       .createConnectAccount(credential.user?.email ?? '');

        //   // user ???????????????????????????
        //   await ref.watch(userViewModelProvider.notifier).createUser(
        //         credential.user,
        //         customerId,
        //         accountId,
        //       );
        // }
      } on FirebaseAuthException catch (e) {
        logger.d(e);
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
  }

  //  SignOut the current user
  Future<void> signOut() async {
    // await FirebaseAuth.instance.signOut();
    try {
      // if (!kIsWeb) {
      //   await GoogleSignIn().signOut();
      // } else {
      await _auth.signOut();
      // }
    } catch (e) {
      logger.e(e);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   Authentication.customSnackBar(
      //     content: 'Error signing out. Try again.',
      //   ),
      // );
    }
  }
}
