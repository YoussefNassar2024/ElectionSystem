import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/screens/login_or_signup/sign_in_screen.dart';

class LoginStreamer extends StatelessWidget {
  const LoginStreamer({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading screen or splash screen if necessary
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          // User is signed in and email is verified, navigate to home screen
          return HomeScreen();
        } else {
          // User is not signed in or email is not verified, navigate to sign-up/login screen
          return const SignInScreen();
        }
      },
    );
  }
}
