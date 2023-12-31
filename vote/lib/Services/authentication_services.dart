import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:vote/custom_components/utils.dart';

class FireBaseAuthenticationServices {
  static String? currentUserID;
  static String getCurrentUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      currentUserID = FirebaseAuth.instance.currentUser?.uid;
    }
    print("This is current user ID: $currentUserID");
    return currentUserID!;
  }

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;

      return user;
    } catch (error) {
      return null;
    }
  }

  static Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on Exception {}
  }

  static Future passwordReset(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSnackBar("Password reset email has been sent !", context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message.toString(), context);
    }
  }

  static Future signUp(
      String email, String password, BuildContext context) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (signInMethods.contains('password')) {
        showSnackBar('Email already exists. Please sign in.', context);
        return;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
}
