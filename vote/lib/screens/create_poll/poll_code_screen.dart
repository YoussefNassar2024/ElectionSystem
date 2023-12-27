import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              color: CustomStyle.colorPalette.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Candidates Saved!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: CustomStyle.colorPalette.white,
                          fontSize: CustomStyle.fontSizes.largeFont + 5,
                          fontFamily: CustomStyle.boldFont)),
                  Text("Share the poll using this code: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomStyle.colorPalette.white,
                          fontSize: CustomStyle.fontSizes.mediumFont,
                          fontFamily: CustomStyle.semiBoldFont)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.7,
                        color: CustomStyle.colorPalette.lightPurple,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.pollCode,
                                style: TextStyle(
                                    fontFamily: CustomStyle.meduimFont,
                                    color: CustomStyle.colorPalette.darkPurple),
                              ),
                              IconButton(
                                onPressed: () async {
                                  //TODO: add copy function
                                  await Clipboard.setData(
                                      ClipboardData(text: widget.pollCode));
                                },
                                icon: Image.asset(
                                  'assets/images/copy.png',
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                            ],
                          ),
                        )),
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
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontSize: CustomStyle.fontSizes.largeFont,
                fontFamily: CustomStyle.boldFont),
          ),
        ],
      ),
    ));
  }
}
