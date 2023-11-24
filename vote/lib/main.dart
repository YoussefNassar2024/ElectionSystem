import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vote/firebase_options.dart';
import 'package:vote/screens/create_poll/poll_title_screen.dart';
import 'package:vote/screens/login_or_signup/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr, child: PollTitleScreen()));
  }
}
