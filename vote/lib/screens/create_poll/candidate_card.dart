import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/style/style.dart';

class CandidateCard extends StatefulWidget {
  const CandidateCard({
    super.key,
    required this.candidateName,
    required this.candidateAge,
    required this.candidateDescription,
    required this.candidateImage,
  });
  final String candidateName;
  final String candidateAge;
  final String candidateDescription;
  final File candidateImage;
  @override
  State<CandidateCard> createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return AutoSizeContainer(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: 8.0,
                ),
                child: CircleAvatar(
                  radius: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.file(
                      widget.candidateImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  children: [
                    Text(
                      "${widget.candidateName}",
                      style: TextStyle(
                          fontFamily: CustomStyle.boldFont,
                          fontSize: CustomStyle.fontSizes.mediumFont,
                          color: CustomStyle.colorPalette.white),
                    ),
                    Text(
                      "${widget.candidateAge} years old",
                      style: TextStyle(
                          fontFamily: CustomStyle.meduimFont,
                          fontSize: CustomStyle.fontSizes.mediumFont,
                          color: CustomStyle.colorPalette.white),
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: (isExpanded)
                    ? Expanded(
                        child: Text(
                          "${widget.candidateDescription}",
                          style: TextStyle(
                              fontFamily: CustomStyle.regularFont,
                              color: CustomStyle.colorPalette.white,
                              fontSize: CustomStyle.fontSizes.subMediumFont),
                        ),
                      )
                    : Text(
                        "${widget.candidateDescription}",
                        style: TextStyle(
                            fontFamily: CustomStyle.regularFont,
                            color: CustomStyle.colorPalette.white,
                            fontSize: CustomStyle.fontSizes.subMediumFont),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
          ),
          customVerticalSpace(context: context),
          (widget.candidateDescription.length >
                  69) //number of chracter before disaperaring
              ? customButton(
                  context: context,
                  color: CustomStyle.colorPalette.lightPurple,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.05,
                  onPressed: () {
                    //TODO: add function
                    if (isExpanded) {
                      setState(() {
                        isExpanded = false;
                      });
                    } else {
                      setState(() {
                        isExpanded = true;
                      });
                    }
                  },
                  childText: (isExpanded) ? "Show less" : "Show More")
              : SizedBox(),
          customVerticalSpace(context: context)
        ],
      ),
    );
  }
}
