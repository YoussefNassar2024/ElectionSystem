import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/screens/create_poll/candidate_card.dart';
import 'package:vote/style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: CandidateAddedScreen(),
    );
  }
}

class CandidateAddedScreen extends StatefulWidget {
  const CandidateAddedScreen({
    super.key,
  });

  @override
  State<CandidateAddedScreen> createState() => AddCandidatesScreenState();
}

class AddCandidatesScreenState extends State<CandidateAddedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/images/shareCode.png',
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 350,
              width: 300,
              color: CustomStyle.colorPalette.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Candidates Saved!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                  const Text("Share the poll using this code: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 100,
                      width: 200,
                      color: CustomStyle.colorPalette.lightPurple, /*child:*/
                    ),
                  )
                ],
              ),
            ),
          ),
          customButton(
            context: context,
            onPressed: () {
              print("Next page");
            },
            childText: "Done",
            color: CustomStyle.colorPalette.lightPurple,
            width: 100,
            height: 50,
            textStyle: const TextStyle(color: Colors.black, fontSize: 30),
          ),
        ],

        //customVerticalSpace(context: context),
      ),
    ));
  }
}
