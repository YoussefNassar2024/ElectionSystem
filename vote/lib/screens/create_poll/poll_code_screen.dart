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
import 'package:vote/screens/home_screen/home_screen.dart';

class PollCodeScreen extends StatefulWidget {
  const PollCodeScreen({
    super.key,
    required this.pollCode,
  });
  final String pollCode;
  @override
  State<PollCodeScreen> createState() => AddCandidatesScreenState();
}

class AddCandidatesScreenState extends State<PollCodeScreen> {
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
                  Text("Candidates Saved!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CustomStyle.colorPalette.white,
                          fontSize: CustomStyle.fontSizes.largeFont,
                          fontFamily: CustomStyle.boldFont)),
                  Text("Share the poll using this code: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomStyle.colorPalette.white,
                          fontSize: CustomStyle.fontSizes.subMediumFont,
                          fontFamily: CustomStyle.semiBoldFont)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        height: 100,
                        width: 200,
                        color: CustomStyle.colorPalette.lightPurple,
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Align(
                                alignment: const Alignment(1.5, -1),
                                child: IconButton(
                                  onPressed: () {
                                    //TODO: add copy function
                                  },
                                  icon: Image.asset('assets/images/copy.png'),
                                  iconSize: 20,
                                  padding: const EdgeInsets.all(35),
                                )))),
                  )
                ],
              ),
            ),
          ),
          customButton(
            context: context,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            childText: "Done",
            color: CustomStyle.colorPalette.lightPurple,
            width: 100,
            height: 50,
            textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontSize: CustomStyle.fontSizes.largeFont),
          ),
        ],
      ),
    ));
  }
}
