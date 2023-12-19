import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/screens/create_poll/add_candidates_screen.dart';
import 'package:vote/style/style.dart';

class PollTitleScreen extends StatelessWidget {
  TextEditingController pollNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        customVerticalSpace(
            context: context,
            height: MediaQuery.of(context).size.height * 0.05),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/pollName.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        customVerticalSpace(
            context: context,
            height: MediaQuery.of(context).size.height * 0.05),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
              color: CustomStyle.colorPalette.purple,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customVerticalSpace(
                  context: context,
                  height: MediaQuery.of(context).size.height * 0.03),
              Text(
                "Enter your poll title",
                style: TextStyle(
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont,
                    color: CustomStyle.colorPalette.white),
              ),
              customVerticalSpace(
                  context: context,
                  height: MediaQuery.of(context).size.height * 0.07),
              customTextField(
                  context: context,
                  textEditingController: pollNameController,
                  height: MediaQuery.of(context).size.height * 0.03,
                  width: MediaQuery.of(context).size.width * 0.7,
                  hintText: "Enter your poll title"),
            ],
          ),
        ),
        customVerticalSpace(
          context: context,
          height: MediaQuery.of(context).size.height * 0.17,
        ),
        customButton(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.07,
            context: context,
            color: CustomStyle.colorPalette.lightPurple,
            onPressed: () {
              //TODO: add function
              if (pollNameController.text.trim() == null ||
                  pollNameController.text.trim().isEmpty ||
                  pollNameController.text.trim() == '') {
                showSnackBar("Please enter poll name", context);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddCandidatesScreen(
                          pollName: pollNameController.text.trim(),
                        )));
              }
            },
            childText: "Next",
            textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontFamily: CustomStyle.boldFont,
                fontSize: 22))
      ]),
    ));
  }
}
