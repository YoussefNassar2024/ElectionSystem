import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/Services/poll_services.dart';
import 'package:vote/Services/vote_services.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/screens/create_poll/poll_title_screen.dart';
import 'package:vote/screens/vote/fill_data_screen.dart';
import 'package:vote/style/style.dart';

class HomeScreen extends StatelessWidget {
  bool isTimestampExpired(Timestamp timestamp, Duration validityDuration) {
    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the expiration time by subtracting the validity duration from the timestamp
    DateTime expirationTime = timestamp.toDate().subtract(validityDuration);

    // Check if the current time is after the calculated expiration time
    return now.isAfter(expirationTime);
  }

  Duration timestampToDuration(Timestamp timestamp) {
    // Get the current time
    DateTime now = DateTime.now();

    // Convert the Timestamp to a DateTime
    DateTime timestampDateTime = timestamp.toDate();

    // Calculate the difference between the current time and the timestamp
    Duration difference = now.difference(timestampDateTime);

    return difference;
  }

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
                  //TODO: add navigation to create poll screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PollTitleScreen()));
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
                    maxLenght: 14,
                    maxLines: 1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.025,
                    hintText: "Enter code",
                  ),
                  customVerticalSpace(
                    context: context,
                  ),
                  customButton(
                      context: context,
                      onPressed: () async {
                        // TODO: add function for joining
                        try {
                          Poll? poll = await PollService.getPollById(
                              joinCodeController.text.trim());
                          if (poll != null) {
                            // The poll is retrieved successfully, navigate to another screen
                            bool hasUserVoted = await VoteService.hasUserVoted(
                                joinCodeController.text.trim(),
                                FireBaseAuthenticationServices
                                    .getCurrentUserId());
                            if (!hasUserVoted) {
                              //TODO: check if poll is not expired
                              Timestamp myTimestamp = Timestamp.now();
                              print(isTimestampExpired(myTimestamp,
                                  timestampToDuration(poll.pollExpiryDate)));
                              if (!isTimestampExpired(myTimestamp,
                                  timestampToDuration(poll.pollExpiryDate))) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FillDataScreen(poll: poll),
                                  ),
                                );
                              } else {
                                showSnackBar("Poll is expired", context);
                              }
                            } else {
                              showSnackBar("You Have Voted!", context);
                            }
                          } else {
                            // Handle the case where the poll is not found
                            showSnackBar('Invalid Code.', context);
                          }
                        } on Exception catch (e) {
                          // Handle the exception, e.g., show an error message
                          showSnackBar('Error: $e', context);
                        }
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
