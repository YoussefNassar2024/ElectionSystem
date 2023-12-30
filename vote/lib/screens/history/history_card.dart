import 'package:flutter/material.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/models/poll_history.dart';
import 'package:vote/screens/history/history_poll_code_screen.dart';
import 'package:vote/screens/history/poll_details_screen.dart';
import 'package:vote/style/style.dart';

//TODO: make it read a list of data
class HistoryCard extends StatefulWidget {
  const HistoryCard(
      {super.key,
      required this.pollName,
      required this.date,
      required this.winnerphotoUrl,
      required this.winnerName,
      required this.winPercentage,
      required this.isPollCreator,
      required this.isNoVotes,
      required this.isDraw,
      required this.isExpired,
      required this.totalNumberOfVotes,
      required this.winnerVotesCount,
      required this.pollDetails,
      required this.winnerId});

  @override
  _HistoryCardState createState() => _HistoryCardState();
  final String pollName;
  final String date;
  final String winnerphotoUrl;
  final String winnerName;
  final double winPercentage;
  final bool isPollCreator;
  final String winnerId;
  final bool isNoVotes;
  final bool isDraw;
  final int totalNumberOfVotes;
  final bool isExpired;
  final int winnerVotesCount;
  final PollHistoryItem pollDetails;
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03),
                child: Text(
                  widget.pollName,
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
              ),
              Text(
                widget.date,
                style: TextStyle(
                    color: CustomStyle.colorPalette.white,
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              ),
              (widget.isNoVotes)
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CircleAvatar(
                            radius: 30,
                            child: (widget.isDraw)
                                ? Image.asset("assets/images/draw.jpg")
                                : Image.network(widget.winnerphotoUrl)),
                      ),
                    )
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
            child: Text(
              (widget.isNoVotes && widget.isPollCreator)
                  ? "Please Approve votes to see results"
                  : (widget.isNoVotes && !widget.isPollCreator)
                      ? "There is no Approved votes"
                      : (widget.isDraw)
                          ? "There is a draw"
                          : (widget.isExpired)
                              ? "${widget.winnerName} won by ${widget.winPercentage}% of votations"
                              : "${widget.winnerName} is winning by ${widget.winPercentage}% of votations",
              style: TextStyle(
                  color: CustomStyle.colorPalette.white,
                  fontFamily: CustomStyle.boldFont,
                  fontSize: CustomStyle.fontSizes.mediumFont),
            ),
          ),
          (widget.isNoVotes || widget.isDraw)
              ? const SizedBox()
              : Text(
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
                //TODO: if condition if poll expired or not
                if (widget.isExpired) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PollDetailsScreen(
                            pollDetails: widget.pollDetails,
                            winPercentage: widget.winPercentage.toString(),
                            winnerPhoto: widget.winnerphotoUrl,
                            isDarw: widget.isDraw,
                            winnerName: widget.winnerName,
                            isExpired: widget.isExpired,
                            totalNumberOfVotes: widget.totalNumberOfVotes,
                            isCreator: widget.isPollCreator,
                            winnerVotesCount: widget.winnerVotesCount,
                            winnerId: widget.winnerId,
                            noApprovedVotes: widget.isNoVotes,
                          )));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HistoryPollCodeScreen(
                            pollDetails: widget.pollDetails,
                            winPercentage: widget.winPercentage.toString(),
                            winnerPhoto: widget.winnerphotoUrl,
                            isDarw: widget.isDraw,
                            winnerName: widget.winnerName,
                            isExpired: widget.isExpired,
                            totalNumberOfVotes: widget.totalNumberOfVotes,
                            isCreator: widget.isPollCreator,
                            winnerVotesCount: widget.winnerVotesCount,
                            winnerId: widget.winnerId,
                            noApprovedVotes: widget.isNoVotes,
                          )));
                }
              },
              childText: "Show more details",
              color: CustomStyle.colorPalette.lightPurple),
          customVerticalSpace(context: context, height: 10),
        ],
      ),
    );
  }
}
