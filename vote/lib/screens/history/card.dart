import 'package:flutter/material.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/style/style.dart';

//TODO: make it read a list of data
class HistoryCard extends StatefulWidget {
  const HistoryCard(
      {super.key,
      required this.pollName,
      required this.date,
      required this.photoUrl,
      required this.winnerName,
      required this.winPercentage});

  @override
  _HistoryCardState createState() => _HistoryCardState();
  final String pollName;
  final String date;
  final String photoUrl;
  final String winnerName;
  final double winPercentage;
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AutoSizeContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03),
                  child: Text(
                    "${widget.pollName}",
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
                  ),
                ),
                Text(
                  "${widget.date}",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                        radius: 30, child: Image.network("${widget.photoUrl}")),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                "${widget.winnerName} won by ${widget.winPercentage}% of votations",
                style: TextStyle(
                    color: CustomStyle.colorPalette.white,
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              ),
            ),
            Text(
              "Congratulations!!",
              style: TextStyle(
                  color: CustomStyle.colorPalette.green,
                  fontFamily: CustomStyle.boldFont,
                  fontSize: CustomStyle.fontSizes.mediumFont),
            ),
            customVerticalSpace(context: context, height: 10),
            customButton(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.05,
                context: context,
                onPressed: () {
                  //TODO: add function
                },
                childText: "Show more details",
                color: CustomStyle.colorPalette.lightPurple),
            customVerticalSpace(context: context, height: 10),
          ],
        ),
      )),
    );
  }
}
