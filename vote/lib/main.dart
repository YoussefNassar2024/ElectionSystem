import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vote/firebase_options.dart';
import 'package:vote/home.dart';
import 'package:vote/screens/history/card.dart';
import 'package:vote/screens/create_poll/add_candidates_screen.dart';
import 'package:vote/screens/login_or_signup/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Directionality(
            textDirection: TextDirection.ltr,
            child: HistoryCard(
              title: "ths",
            )));
  }
}
