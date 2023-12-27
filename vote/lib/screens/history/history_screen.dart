import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/style/style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: add back arrow
        title: Center(
            child: Text(
          "Your Poll History",
          style: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontFamily: CustomStyle.boldFont),
        )),
        backgroundColor: CustomStyle.colorPalette.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customVerticalSpace(context: context),
          TextField(
            controller: TextEditingController(text: "Candidate Name"),
          ), // Add candidate name here
          Center(child: Image.asset("assets/images/history.png")),
          customVerticalSpace(context: context),
          TextField(
            controller: TextEditingController(text: "Candidate winning data"),
          ), // Add data of how far his votes are, etc
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 300,
              width: 300,
              color: CustomStyle.colorPalette.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => ()));
            },
            childText: "Show Votes",
            color: CustomStyle.colorPalette.lightPurple,
            width: 150,
            height: 50,
            textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontSize: CustomStyle.fontSizes.largeFont),
          ),

          customButton(
            context: context,
            onPressed: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => ()));
            },
            childText: "Show more details",
            color: CustomStyle.colorPalette.lightPurple,
            width: 150,
            height: 50,
            textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontSize: CustomStyle.fontSizes.largeFont),
          ),

          //TODO: add code to read history and show cards
        ],
      ),
    );
  }
}
