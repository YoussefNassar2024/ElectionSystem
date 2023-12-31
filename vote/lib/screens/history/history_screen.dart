import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vote/Services/poll_services.dart';
import 'package:vote/Services/results_services.dart';
import 'package:vote/Services/user_services.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/models/poll_history.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/models/results_model.dart';
import 'package:vote/models/user_model.dart';
import 'package:vote/screens/history/history_card.dart';
import 'package:vote/style/style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<void> dataFuture;
  Timestamp myTimestamp = Timestamp.now();

  User? user;
  List<PollHistoryItem> pollsAndResults = [];
  String convertTimeStampToString(Timestamp timestamp) {
    // Convert the Timestamp to a DateTime object
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime object as a string in "dd/MM/yyyy" format
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formattedDate;
  }

  Future<void> readData() async {
    user = await UserService.getUserData();
    print(user!);

    user!.contributedPolls
        .removeWhere((element) => user!.createdPolls.contains(element));

    for (var i = 0; i < user!.createdPolls.length; i++) {
      final poll = await PollService.getPollById(user!.createdPolls[i]);
      final results = await ResultsService.getResultsByPollId(poll!.pollCode);
      pollsAndResults.add(
          PollHistoryItem(poll: poll, results: results, isPollCreator: true));
    }

    for (var i = 0; i < user!.contributedPolls.length; i++) {
      final poll = await PollService.getPollById(user!.contributedPolls[i]);
      final results = await ResultsService.getResultsByPollId(poll!.pollCode);
      pollsAndResults.add(
          PollHistoryItem(poll: poll, results: results, isPollCreator: false));
    }
  }

  String winnerCandidateCalculator(int index) {
    int biggestNumber = pollsAndResults[index]
        .results!
        .candidateResults
        .map((result) =>
            result.values.last) // Get the last value from each candidateResult
        .reduce((max, current) => max > current ? max : current);
    String winnerCandidateId = pollsAndResults[index]
        .results!
        .candidateResults
        .where((element) => element.values.last == biggestNumber)
        .first
        .keys
        .first
        .toString();
    return winnerCandidateId;
  }

  Candidate? getCandidateFromId(int index) {
    String candidateId = winnerCandidateCalculator(index);
    for (var i = 0; i < pollsAndResults[index].poll!.candidates.length; i++) {
      if (pollsAndResults[index].poll!.candidates[i].Id == candidateId) {
        return pollsAndResults[index].poll!.candidates[i];
      }
    }
    return null;
  }

  int calculateTotalNumberOfVotes(int index) {
    int total = 0;
    for (var i = 0;
        i < pollsAndResults[index].results!.candidateResults.length;
        i++) {
      total += int.parse(pollsAndResults[index]
          .results!
          .candidateResults[i]
          .values
          .last
          .toString());
    }

    return total;
  }

  bool isNoVotes(int index) {
    int total = calculateTotalNumberOfVotes(index);
    if (total == 0) {
      return true;
    } else {
      return false;
    }
  }

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

  bool isDraw(Results results) {
    bool isDraw = false;
    for (var i = 0; i < results.candidateResults.length; i++) {
      for (var j = i + 1; j < results.candidateResults.length; j++) {
        if (results.candidateResults[i].values.last ==
            results.candidateResults[j].values.last) {
          isDraw = true;
        }
      }
    }
    return isDraw;
  }

  double winnerPercentageCalculator(int index) {
    int biggestNumber = pollsAndResults[index]
        .results!
        .candidateResults
        .map((result) => result.values.last)
        .reduce((max, current) => max > current ? max : current);
    int totalNumberOfVotes = calculateTotalNumberOfVotes(index);
    return (biggestNumber / totalNumberOfVotes) * 100;
  }

  int winnerVoteCounter(int index) {
    int biggestNumber = pollsAndResults[index]
        .results!
        .candidateResults
        .map((result) => result.values.last)
        .reduce((max, current) => max > current ? max : current);
    return biggestNumber;
  }

  @override
  void initState() {
    super.initState();
    dataFuture = readData();
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
        title: Center(
            child: Text(
          "Your Polls History",
          style: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontFamily: CustomStyle.boldFont),
        )),
        backgroundColor: CustomStyle.colorPalette.purple,
      ),
      body: FutureBuilder<void>(
          future: dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still running, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurred, handle it accordingly
              print("this is error: " + snapshot.error.toString());
              return const Center(child: Text('An error occured'));
            } else {
              // If the Future completed successfully, build your widget tree
              return (pollsAndResults.isNotEmpty)
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customVerticalSpace(context: context),
                            Center(
                                child:
                                    Image.asset("assets/images/history.png")),
                            customVerticalSpace(context: context),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: pollsAndResults.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        HistoryCard(
                                          winnerId:
                                              getCandidateFromId(index)!.Id,
                                          totalNumberOfVotes:
                                              calculateTotalNumberOfVotes(
                                                  index),
                                          pollName: pollsAndResults[index]
                                              .poll!
                                              .title,
                                          date: convertTimeStampToString(
                                              pollsAndResults[index]
                                                  .poll!
                                                  .pollExpiryDate),
                                          winnerphotoUrl:
                                              getCandidateFromId(index)!.photo,
                                          winnerName:
                                              getCandidateFromId(index)!.name,
                                          winPercentage:
                                              winnerPercentageCalculator(index),
                                          isPollCreator: pollsAndResults[index]
                                              .isPollCreator,
                                          winnerVotesCount:
                                              winnerVoteCounter(index),
                                          isNoVotes: isNoVotes(index),
                                          isDraw: isDraw(
                                              pollsAndResults[index].results!),
                                          isExpired: isTimestampExpired(
                                              myTimestamp,
                                              timestampToDuration(
                                                  pollsAndResults[index]
                                                      .poll!
                                                      .pollExpiryDate)),
                                          pollDetails: pollsAndResults[index],
                                        ),
                                        customVerticalSpace(context: context)
                                      ],
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Image.asset("assets/images/noHistory.jpg",
                              width: MediaQuery.of(context).size.width * 0.8),
                          Text(
                            "There is no recent activity",
                            style: TextStyle(
                                color: CustomStyle.colorPalette.darkPurple,
                                fontFamily: CustomStyle.boldFont,
                                fontSize: CustomStyle.fontSizes.largeFont),
                          )
                        ],
                      ),
                    );
            }
          }),
    );
  }
}
