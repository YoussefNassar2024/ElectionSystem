import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vote/firebase_options.dart';
import 'package:vote/home.dart';
import 'package:vote/screens/create_poll/add_required_data_screen.dart';
import 'package:vote/screens/create_poll/dead_line_picker_screen.dart';
import 'package:vote/screens/history/card.dart';
import 'package:vote/screens/create_poll/add_candidates_screen.dart';
import 'package:vote/screens/history/history_screen.dart';
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
            textDirection: TextDirection.ltr, child: AddRequiredData()
            //     HistoryCard(
            //   pollName: 'NU Poll',
            //   date: '12/12/2023',
            //   winnerName: 'Youssef Ahmed',
            //   winPercentage: 62,
            //   photoUrl:
            //       "https://firebasestorage.googleapis.com/v0/b/election-37353.appspot.com/o/94936068.jpg?alt=media&token=3c9ee6f6-8059-4587-9b3d-209db6454eba",
            // )
            ));
  }
}
