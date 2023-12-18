import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/style/style.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController joinCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.05),
            Center(
                child: Image.asset(
              "assets/images/homeScreen.png",
              width: MediaQuery.of(context).size.width * 0.7,
            )),
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.05),
            customButton(
                context: context,
                onPressed: () {
                  //TODO: add navigation to history screen
                },
                childText: "Show history",
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width * 0.7),
            customVerticalSpace(
              context: context,
            ),
            customButton(
                context: context,
                onPressed: () {
                  //TODO: add navigation to history screen
                },
                childText: "Create poll",
                height: MediaQuery.of(context).size.height * 0.09,
                width: MediaQuery.of(context).size.width * 0.7),
            customVerticalSpace(
              context: context,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  color: CustomStyle.colorPalette.purple,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.045),
                      child: Text(
                        "Vote Now!",
                        style: TextStyle(
                            fontSize: CustomStyle.fontSizes.mediumFont,
                            fontFamily: CustomStyle.boldFont,
                            color: CustomStyle.colorPalette.white),
                      ),
                    ),
                  ),
                  customVerticalSpace(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.04),
                  customTextField(
                    textEditingController: joinCodeController,
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.025,
                    hintText: "Enter code",
                  ),
                  customVerticalSpace(
                    context: context,
                  ),
                  customButton(
                      context: context,
                      onPressed: () {
                        // TODO: add function for joining
                      },
                      childText: "Vote",
                      color: CustomStyle.colorPalette.lightPurple,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      textStyle: TextStyle(
                          color: CustomStyle.colorPalette.darkPurple,
                          fontSize: CustomStyle.fontSizes.largeFont,
                          fontFamily: CustomStyle.boldFont))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
