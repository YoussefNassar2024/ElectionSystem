import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/models/poll_history.dart';
import 'package:vote/screens/history/poll_details_screen.dart';
import 'package:vote/style/style.dart';

class HistoryPollCodeScreen extends StatefulWidget {
  const HistoryPollCodeScreen(
      {super.key,
      required this.isExpired,
      required this.pollDetails,
      required this.isCreator,
      required this.winPercentage,
      required this.winnerName,
      required this.isDarw,
      required this.winnerPhoto,
      required this.totalNumberOfVotes,
      required this.winnerVotesCount,
      required this.winnerId,
      required this.noApprovedVotes});
  final bool isExpired;
  final PollHistoryItem pollDetails;
  final bool isCreator;
  final String winPercentage;
  final String winnerName;
  final bool isDarw;
  final String winnerPhoto;
  final int totalNumberOfVotes;
  final int winnerVotesCount;
  final String winnerId;
  final bool noApprovedVotes;
  @override
  State<HistoryPollCodeScreen> createState() => _HistoryPollCodeScreenState();
}

class _HistoryPollCodeScreenState extends State<HistoryPollCodeScreen> {
  int getNumberOfVotesForCandidate(String candidateId) {
    int numberOfVotes = widget.pollDetails.results!.candidateResults
        .where((element) => element.keys.first == candidateId)
        .first
        .values
        .last;
    return numberOfVotes;
  }

  double getCandidatePercentage(String candidateId) {
    return (getNumberOfVotesForCandidate(candidateId) /
            widget.totalNumberOfVotes) *
        100;
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customVerticalSpace(context: context),
            Center(
              child: Text(
                (widget.isDarw && widget.noApprovedVotes)
                    ? "No votes"
                    : (widget.isDarw)
                        ? "Draw"
                        : widget.winnerName,
                style: (!widget.isDarw)
                    ? TextStyle(
                        color: CustomStyle.colorPalette.green,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.largeFont)
                    : TextStyle(
                        color: CustomStyle.colorPalette.darkPurple,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.largeFont),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(85),
              child: CircleAvatar(
                  radius: 85,
                  child: (widget.isDarw)
                      ? Image.asset("assets/images/draw.jpg")
                      : Image.network(
                          "${widget.winnerPhoto}",
                          fit: BoxFit.contain,
                        )),
            ),
            customVerticalSpace(context: context),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (widget.noApprovedVotes)
                      ? MediaQuery.of(context).size.width * 0.1
                      : MediaQuery.of(context).size.width * 0.16),
              child: Text(
                (widget.isDarw && widget.noApprovedVotes)
                    ? "Admin did not approve votes yet."
                    : (widget.isDarw)
                        ? "This poll is ended in draw, the result can be changed later, so stay tuned"
                        : "Winner by ${widget.winPercentage}% of votations ${widget.winnerVotesCount} persons votes for Ahmed Mohamed from ${widget.totalNumberOfVotes} persons",
                style: (!widget.isDarw)
                    ? TextStyle(
                        color: CustomStyle.colorPalette.green,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont)
                    : TextStyle(
                        color: CustomStyle.colorPalette.darkPurple,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
              ),
            ),
            customVerticalSpace(context: context),
            AutoSizeContainer(
              width: MediaQuery.of(context).size.width * 0.8,
              color: CustomStyle.colorPalette.purple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customVerticalSpace(context: context),
                  Text("Share the poll using this code: ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: CustomStyle.colorPalette.white,
                          fontSize: CustomStyle.fontSizes.mediumFont,
                          fontFamily: CustomStyle.semiBoldFont)),
                  customVerticalSpace(context: context),
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
                                widget.pollDetails.poll!.pollCode,
                                style: TextStyle(
                                    fontFamily: CustomStyle.meduimFont,
                                    color: CustomStyle.colorPalette.darkPurple),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: widget.pollDetails.poll!.pollCode));
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
                  ),
                  customVerticalSpace(context: context),
                ],
              ),
            ),
            customVerticalSpace(context: context),
            customVerticalSpace(context: context),
            (widget.isCreator)
                ? customButton(
                    context: context,
                    onPressed: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => ()));
                    },
                    childText: "Show Votes",
                    color: CustomStyle.colorPalette.lightPurple,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.06,
                    textStyle: TextStyle(
                        color: CustomStyle.colorPalette.darkPurple,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.largeFont),
                  )
                : const SizedBox(),
            customVerticalSpace(context: context),
            customButton(
              context: context,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PollDetailsScreen(
                          pollDetails: widget.pollDetails,
                          winPercentage: widget.winPercentage.toString(),
                          winnerPhoto: widget.winnerPhoto,
                          isDarw: widget.isDarw,
                          winnerName: widget.winnerName,
                          isExpired: widget.isExpired,
                          totalNumberOfVotes: widget.totalNumberOfVotes,
                          isCreator: widget.isCreator,
                          winnerVotesCount: widget.winnerVotesCount,
                          winnerId: widget.winnerId,
                          noApprovedVotes: widget.noApprovedVotes,
                        )));
              },
              childText: "Show more details",
              color: CustomStyle.colorPalette.lightPurple,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              textStyle: TextStyle(
                  color: CustomStyle.colorPalette.darkPurple,
                  fontSize: CustomStyle.fontSizes.largeFont,
                  fontFamily: CustomStyle.boldFont),
            ),
          ],
        ),
      ),
    );
  }
}
