import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vote/firebase_options.dart';
import 'package:vote/screens/login_or_signup/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FirstScreen());
}
