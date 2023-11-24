import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vote/home.dart';
import 'package:vote/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading screen or splash screen if necessary
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.emailVerified) {
          // User is signed in and email is verified, navigate to home screen
          return HomeScreen();
        } else {
          // User is not signed in or email is not verified, navigate to sign-up/login screen
          return MyApp();
        }
      },
    );
  }
}
