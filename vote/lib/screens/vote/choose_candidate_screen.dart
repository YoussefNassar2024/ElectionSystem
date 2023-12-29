import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/Services/results_services.dart';
import 'package:vote/Services/storage_services.dart';
import 'package:vote/Services/user_services.dart';
import 'package:vote/Services/vote_services.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/models/vote_model.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/style/style.dart';

class ChooseCandidateScreen extends StatefulWidget {
  const ChooseCandidateScreen(
      {super.key, required this.poll, required this.userData});
  final Poll poll;
  final Map<String, dynamic> userData;
  @override
  State<ChooseCandidateScreen> createState() => _ChooseCandidateScreenState();
}

class _ChooseCandidateScreenState extends State<ChooseCandidateScreen> {
  List<bool> isExpanded = [];
  String selectedCandidateID = '';
  late String selectedCandidateName;
  List<Map<String, String>> nameOfFieldsThatContainImages = [];
  Map<String, String> dataToUpload = {};
  void checkForImages() {
    for (var data in widget.poll.requiredData) {
      if (data['data type'] == 'Image') {
        print('Found Image in data type for ${data['data name']}');
        nameOfFieldsThatContainImages.add({
          '${data.values.first}': '${data.values.last}',
        });
        print(nameOfFieldsThatContainImages);
      } else if (data['data type'] == 'Text' || data['data type'] == 'Number') {
        dataToUpload.addAll({
          '${data.values.first}': '${data.values.last}',
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.poll.candidates.length; i++) {
      isExpanded.add(false);
    }
    checkForImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.91,
            child: SingleChildScrollView(
                reverse: true,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customVerticalSpace(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.05),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/userVote.png',
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ),
                      customVerticalSpace(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.05),
                      ListView.builder(
                          itemCount: widget.poll.candidates.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCandidateID =
                                          widget.poll.candidates[index].Id;
                                      selectedCandidateName =
                                          widget.poll.candidates[index].name;
                                    });
                                    print(selectedCandidateID);
                                  },
                                  child: AutoSizeContainer(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 40,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      child: Image.network(
                                                        widget
                                                            .poll
                                                            .candidates[index]
                                                            .photo,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${widget.poll.candidates[index].name}",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  CustomStyle
                                                                      .boldFont,
                                                              fontSize:
                                                                  CustomStyle
                                                                      .fontSizes
                                                                      .mediumFont,
                                                              color: CustomStyle
                                                                  .colorPalette
                                                                  .white),
                                                        ),
                                                        Text(
                                                          "${widget.poll.candidates[index].age} years old",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  CustomStyle
                                                                      .meduimFont,
                                                              fontSize:
                                                                  CustomStyle
                                                                      .fontSizes
                                                                      .mediumFont,
                                                              color: CustomStyle
                                                                  .colorPalette
                                                                  .white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //add check icon
                                            (selectedCandidateID ==
                                                    widget.poll
                                                        .candidates[index].Id)
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
                                                    child: Image.asset(
                                                        "assets/images/checkedIcon.png"),
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15.0),
                                              child: (isExpanded[index])
                                                  ? Expanded(
                                                      child: Text(
                                                        "${widget.poll.candidates[index].description}",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                CustomStyle
                                                                    .regularFont,
                                                            color: CustomStyle
                                                                .colorPalette
                                                                .white,
                                                            fontSize: CustomStyle
                                                                .fontSizes
                                                                .subMediumFont),
                                                      ),
                                                    )
                                                  : Text(
                                                      "${widget.poll.candidates[index].description}",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              CustomStyle
                                                                  .regularFont,
                                                          color: CustomStyle
                                                              .colorPalette
                                                              .white,
                                                          fontSize: CustomStyle
                                                              .fontSizes
                                                              .subMediumFont),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                        ),
                                        customVerticalSpace(context: context),
                                        (widget.poll.candidates[index]
                                                    .description.length >
                                                69) //number of chracter before disaperaring
                                            ? customButton(
                                                context: context,
                                                color: CustomStyle
                                                    .colorPalette.lightPurple,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                onPressed: () {
                                                  //TODO: add function
                                                  if (isExpanded[index]) {
                                                    setState(() {
                                                      isExpanded[index] = false;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      isExpanded[index] = true;
                                                    });
                                                  }
                                                },
                                                childText: (isExpanded[index])
                                                    ? "Show less"
                                                    : "Show More")
                                            : SizedBox(),
                                        customVerticalSpace(context: context)
                                      ],
                                    ),
                                  ),
                                ),
                                customVerticalSpace(context: context)
                              ],
                            );
                          }))
                    ])),
          ),
          customButton(
              color: CustomStyle.colorPalette.lightPurple,
              width: MediaQuery.of(context).size.width * 0.7,
              textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontFamily: CustomStyle.boldFont,
                fontSize: CustomStyle.fontSizes.largeFont,
              ),
              height: MediaQuery.of(context).size.height * 0.07,
              context: context,
              onPressed: () {
                //TODO: add vote function
                if (selectedCandidateName != null) {
                  //TODO: add dialog
                  _showPopup(
                      context, selectedCandidateID, selectedCandidateName);
                } else {
                  showSnackBar("Please choose candidate", context);
                }
              },
              childText: "Done")
        ],
      ),
    );
  }

  void _showPopup(BuildContext context, String selectedCandidateId,
      String selectedCandidatename) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
            child: AlertDialog(
                actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(
                      context: context,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      childText: 'NO',
                      color: CustomStyle.colorPalette.red),
                  customButton(
                      context: context,
                      onPressed: () async {
                        //TODO: add function

                        showLoadingScreen(context);
                        try {
                          List<Map<String, dynamic>> imagesToUpload = [];

                          for (var field in nameOfFieldsThatContainImages) {
                            var keyToSearch = field.keys.first; //ID Photo
                            if (widget.userData.containsKey(keyToSearch)) {
                              var fileLink =
                                  widget.userData[keyToSearch]; //File
                              imagesToUpload.add({"$keyToSearch": fileLink});
                            } else {
                              print('$keyToSearch not found in the map.');
                            }
                          }
                          print(imagesToUpload);
                          List<Map<String, String>> newImagesLinks = [];
                          for (var i = 0; i < imagesToUpload.length; i++) {
                            newImagesLinks.add({
                              "${imagesToUpload[i].keys.first}":
                                  " ${await StorageServices.uploadVoterImageToStorage(imagesToUpload[i].values.last, widget.poll.pollCode, imagesToUpload[i].keys.first, FireBaseAuthenticationServices.getCurrentUserId())}"
                            });
                          }

                          for (var i = 0; i < newImagesLinks.length; i++) {
                            dataToUpload.addAll(newImagesLinks[i]);
                          }
                          await VoteService.uploadVote(
                              Vote(
                                  candidateId: selectedCandidateID,
                                  pollId: widget.poll.pollCode,
                                  voterId: FireBaseAuthenticationServices
                                      .getCurrentUserId(),
                                  voterData: dataToUpload),
                              widget.poll.pollCode);
                          await ResultsService.placeVote(
                              widget.poll.pollCode,
                              int.parse(
                                  selectedCandidateId)); //TODO: remove and add to approve votes
                          await UserService.addContributedPoll(
                              widget.poll.pollCode);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => HomeScreen())));
                        } on Exception catch (e) {
                          removeLoadingScreen(context);
                          showSnackBar(e.toString(), context);
                        }
                      },
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      childText: 'Yes',
                      color: CustomStyle.colorPalette.green)
                ],
              )
            ],
                backgroundColor: CustomStyle.colorPalette.lightPurple,
                title: Text(
                  'Are you sure you want to vote to $selectedCandidateName?',
                  style: TextStyle(
                      color: CustomStyle.colorPalette.darkPurple,
                      fontFamily: CustomStyle.boldFont),
                ),
                content: IntrinsicHeight(
                  child: Text(
                    'Note that your vote can not be changed',
                    style: TextStyle(
                        color: CustomStyle.colorPalette.darkPurple,
                        fontFamily: CustomStyle.boldFont),
                  ),
                )));
      },
    );
  }
}
