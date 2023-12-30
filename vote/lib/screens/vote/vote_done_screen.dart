import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/style/style.dart';

class VoteDoneScreen extends StatelessWidget {
  const VoteDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        return Future.value(false);
      },
      child: Scaffold(
        body: Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/voteDone.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vote Done!!!  ",
                      style: TextStyle(
                          fontFamily: CustomStyle.boldFont,
                          fontSize: CustomStyle.fontSizes.mediumFont,
                          color: CustomStyle.colorPalette.darkPurple),
                    ),
                    Image.asset(
                      'assets/images/checkedIcon.png',
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: customButton(
                      context: context,
                      onPressed: () {
                        //TODO: add navigation
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      childText: "Done"),
                )
              ]),
        ),
      ),
    );
  }
}
