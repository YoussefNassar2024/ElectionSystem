import 'package:flutter/material.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/models/poll_history.dart';
import 'package:vote/screens/history/show_votes_screen.dart';
import 'package:vote/style/style.dart';

class PollDetailsScreen extends StatefulWidget {
  const PollDetailsScreen(
      {super.key,
      required this.isExpired,
      required this.isCreator,
      required this.winnerName,
      required this.isDarw,
      required this.winnerPhoto,
      required this.winPercentage,
      required this.totalNumberOfVotes,
      required this.winnerVotesCount,
      required this.pollDetails,
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
  State<PollDetailsScreen> createState() => _PollDetailsScreenState();
}

class _PollDetailsScreenState extends State<PollDetailsScreen> {
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: CustomStyle.colorPalette.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: CustomStyle.colorPalette.purple,
        title: Center(
            child: Text(
          widget.pollDetails.poll!.title,
          style: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontFamily: CustomStyle.boldFont),
        )),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
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
              customVerticalSpace(context: context),
              ClipRRect(
                borderRadius: BorderRadius.circular(85),
                child: CircleAvatar(
                    radius: 85,
                    child: (widget.isDarw)
                        ? Image.asset("assets/images/draw.jpg")
                        : Image.network(
                            widget.winnerPhoto,
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
                          : "Winner by ${widget.winPercentage}% of votations ${widget.winnerVotesCount} persons votes for ${widget.winnerName} from ${widget.totalNumberOfVotes} persons",
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: widget.pollDetails.poll!.candidates.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AutoSizeContainer(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Flexible(
                                        child: Text(
                                          (widget.noApprovedVotes)
                                              ? "There are no votes approved"
                                              : "${widget.pollDetails.poll!.candidates[index].name} got only ${getCandidatePercentage(widget.pollDetails.poll!.candidates[index].Id)}% of votations",
                                          style: TextStyle(
                                              fontFamily: CustomStyle.boldFont,
                                              fontSize: CustomStyle
                                                  .fontSizes.mediumFont,
                                              color: CustomStyle
                                                  .colorPalette.white),
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CircleAvatar(
                                          radius: 30,
                                          child: Image.network(widget
                                              .pollDetails
                                              .poll!
                                              .candidates[index]
                                              .photo)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Flexible(
                                    child: Text(
                                      "${getNumberOfVotesForCandidate(widget.pollDetails.poll!.candidates[index].Id)} persons only voted for ${widget.pollDetails.poll!.candidates[index].name} from ${widget.totalNumberOfVotes}",
                                      style: TextStyle(
                                          fontFamily: CustomStyle.boldFont,
                                          fontSize:
                                              CustomStyle.fontSizes.mediumFont,
                                          color:
                                              CustomStyle.colorPalette.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (widget.isDarw)
                                    ? const SizedBox()
                                    : Text(
                                        (widget.pollDetails.poll!
                                                    .candidates[index].Id ==
                                                widget.winnerId)
                                            ? "Congratulations!!"
                                            : "Hard Luck!!",
                                        style: TextStyle(
                                            color: (widget.pollDetails.poll!
                                                        .candidates[index].Id ==
                                                    widget.winnerId)
                                                ? CustomStyle.colorPalette.green
                                                : CustomStyle.colorPalette.red,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.subMediumFont),
                                      )
                              ],
                            ),
                          )),
                          customVerticalSpace(context: context)
                        ],
                      );
                    }),
              ),
              (widget.isCreator)
                  ? customButton(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.6,
                      color: CustomStyle.colorPalette.lightPurple,
                      onPressed: () {
                        //TODO: add navigation
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShowVotesScreen(
                                  pollDetails: widget.pollDetails,
                                )));
                      },
                      childText: "Show Votes",
                      textStyle: TextStyle(
                          color: CustomStyle.colorPalette.darkPurple,
                          fontFamily: CustomStyle.boldFont,
                          fontSize: CustomStyle.fontSizes.mediumFont))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
