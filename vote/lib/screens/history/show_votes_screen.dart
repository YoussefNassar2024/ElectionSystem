import 'package:flutter/material.dart';
import 'package:vote/Services/results_services.dart';
import 'package:vote/Services/vote_services.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_history.dart';
import 'package:vote/models/vote_model.dart';
import 'package:vote/style/style.dart';
import 'package:photo_view/photo_view.dart';

class ShowVotesScreen extends StatefulWidget {
  const ShowVotesScreen({
    super.key,
    required this.pollDetails,
  });
  final PollHistoryItem pollDetails;

  @override
  State<ShowVotesScreen> createState() => _ShowVotesScreenState();
}

class _ShowVotesScreenState extends State<ShowVotesScreen> {
  late Stream<List<Vote>> votesStream;

  @override
  void initState() {
    super.initState();
    votesStream = VoteService.getVotesStream(widget.pollDetails.poll!.pollCode);
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
        title: Text(
          "Details",
          style: TextStyle(
            color: CustomStyle.colorPalette.white,
            fontFamily: CustomStyle.boldFont,
          ),
        ),
        backgroundColor: CustomStyle.colorPalette.purple,
      ),
      body: StreamBuilder<List<Vote>>(
        stream: votesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          } else {
            List<Vote> votes = snapshot.data ?? [];
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    customVerticalSpace(context: context),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: votes.length,
                      itemBuilder: (context, index) {
                        return (!votes[index].isApproved)
                            ? Column(
                                children: [
                                  AutoSizeContainer(
                                      child: Column(
                                    children: [
                                      customVerticalSpace(context: context),
                                      Text(
                                        "Vote ID: ${votes[index].voterId}",
                                        style: TextStyle(
                                            color:
                                                CustomStyle.colorPalette.white,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.subMediumFont),
                                      ),
                                      customVerticalSpace(context: context),
                                      customButton(
                                          context: context,
                                          onPressed: () {
                                            _showPopup(context, votes[index]);
                                          },
                                          childText: "Show Data",
                                          color: CustomStyle
                                              .colorPalette.lightPurple,
                                          textStyle: TextStyle(
                                              color: CustomStyle
                                                  .colorPalette.darkPurple,
                                              fontFamily: CustomStyle.boldFont,
                                              fontSize: CustomStyle
                                                  .fontSizes.subMediumFont),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ))
                                ],
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  void _showPopup(BuildContext context, Vote vote) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child: AlertDialog(
            backgroundColor: CustomStyle.colorPalette.lightPurple,
            title: Text(
              "Vote ID: ${vote.voterId}",
              style: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontFamily: CustomStyle.boldFont,
                fontSize: CustomStyle.fontSizes.smallFont,
              ),
            ),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  for (var entry in vote.voterData.entries)
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "${entry.key}: ",
                                    style: TextStyle(
                                      color:
                                          CustomStyle.colorPalette.darkPurple,
                                      fontFamily: CustomStyle.boldFont,
                                      fontSize:
                                          CustomStyle.fontSizes.mediumFont,
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImage(
                                                    "${entry.value}"))),
                                    child: Image.network(
                                      "${entry.value}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        print('Error loading image: $error');
                                        return Text(
                                          "${entry.value}",
                                          style: TextStyle(
                                            color: CustomStyle
                                                .colorPalette.darkPurple,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.mediumFont,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                customVerticalSpace(context: context),
                              ],
                            )),
                        customVerticalSpace(context: context),
                      ],
                    ),
                  customButton(
                      context: context,
                      onPressed: () async {
                        //TODO: add approve function
                        try {
                          showLoadingScreen(context);
                          await VoteService.approveVote(
                              vote, widget.pollDetails.poll!.pollCode);
                          await ResultsService.placeVote(
                              widget.pollDetails.poll!.pollCode,
                              int.parse(vote.candidateId));
                          removeLoadingScreen(context);
                        } on Exception catch (e) {
                          showSnackBar("Error while Approving", context);
                        }
                        Navigator.of(context).pop();
                      },
                      childText: "Approve",
                      color: CustomStyle.colorPalette.green,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5),
                  customVerticalSpace(context: context),
                  customButton(
                      context: context,
                      onPressed: () async {
                        //TODO: decline approve function
                        try {
                          showLoadingScreen(context);
                          await VoteService.deleteVote(
                              vote.voterId, widget.pollDetails.poll!.pollCode);
                          removeLoadingScreen(context);
                        } on Exception catch (e) {
                          showSnackBar("Error while Declining", context);
                        }
                        Navigator.of(context).pop();
                      },
                      childText: "Decline",
                      color: CustomStyle.colorPalette.red,
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  FullScreenImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent.withOpacity(1),
          actions: const []),
      body: PhotoView(
        errorBuilder: (context, error, stackTrace) {
          Navigator.of(context).pop();
          return SizedBox();
        },
        imageProvider: NetworkImage(
          imageUrl,
        ),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
