import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/screens/create_poll/candidate_card.dart';
import 'package:vote/style/style.dart';

// Calculate timestamp based on the user's age
// int timestamp = DateTime.now().subtract(Duration(days: age * 365)).millisecondsSinceEpoch;

class AddCandidatesScreen extends StatefulWidget {
  @override
  State<AddCandidatesScreen> createState() => _AddCandidatesScreenState();
}

class _AddCandidatesScreenState extends State<AddCandidatesScreen> {
  List<Candidate> candidates = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> descriptionControllers = [];
  List<TextEditingController> ageControllers = [];
  bool isCandidatesEmpty = true;
  List<Widget> candidatesEditingWidget = [];
  List<Widget> candidatesCards = [];
  int numOfCandidates = 0;
  List<File> selectedImages = [];
  bool isAddingCandidates = false;
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void updatePhoto(
      TextEditingController nameController,
      TextEditingController ageController,
      TextEditingController descriptionController) {
    if (numOfCandidates == selectedImages.length && selectedImages.isNotEmpty) {
      candidatesEditingWidget.removeAt(candidatesEditingWidget.length - 1);
      candidatesEditingWidget.add(Column(
        children: [
          AutoSizeContainer(
              width: MediaQuery.of(context).size.width * 0.8,
              color: CustomStyle.colorPalette.purple,
              child: Column(children: [
                customVerticalSpace(context: context),
                Text(
                  "Please add candidate #$numOfCandidates:",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
                customVerticalSpace(context: context),
                GestureDetector(
                    onTap: () async {
                      if (selectedImages.length == numOfCandidates) {
                        selectedImages.removeLast();
                        await _pickImages();
                        print(selectedImages);
                        updatePhoto(
                            nameControllers[nameControllers.length - 1],
                            ageControllers[ageControllers.length - 1],
                            descriptionControllers[
                                descriptionControllers.length - 1]);
                        setState(() {});
                      } else {
                        await _pickImages();
                        print(selectedImages);
                        updatePhoto(
                            nameControllers[nameControllers.length - 1],
                            ageControllers[ageControllers.length - 1],
                            descriptionControllers[
                                descriptionControllers.length - 1]);
                        setState(() {});
                      }
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: CustomStyle.colorPalette.lightPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (numOfCandidates == selectedImages.length &&
                              selectedImages.isNotEmpty)
                          ? Image.file(
                              selectedImages.last,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text("Select photo"),
                            ),
                    )),
                customVerticalSpace(context: context),
                Text(
                  "Please add name",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
                customVerticalSpace(context: context),
                customTextField(
                    maxLines: 1,
                    textEditingController: nameController,
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.6,
                    hintText: "Enter Name"),
                customVerticalSpace(context: context),
                Text(
                  "Please add age",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
                customVerticalSpace(context: context),
                customTextField(
                    maxLines: 1,
                    textEditingController: ageController,
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.6,
                    hintText: "Enter Age"),
                customVerticalSpace(context: context),
                Text(
                  "Please add description",
                  style: TextStyle(
                      color: CustomStyle.colorPalette.white,
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                ),
                customVerticalSpace(context: context),
                customTextField(
                    textEditingController: descriptionController,
                    context: context,
                    width: MediaQuery.of(context).size.width * 0.7,
                    hintText: "Enter Description"),
                customVerticalSpace(context: context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customButton(
                        context: context,
                        onPressed: () {
                          print(nameControllers.length);

                          setState(() {
                            candidatesEditingWidget
                                .removeAt(candidatesEditingWidget.length - 1);
                            nameControllers
                                .removeAt(nameControllers.length - 1);
                            ageControllers.removeAt(ageControllers.length - 1);
                            descriptionControllers
                                .removeAt(descriptionControllers.length - 1);
                            if (selectedImages.length == numOfCandidates) {
                              selectedImages
                                  .removeAt(selectedImages.length - 1);
                            }
                            numOfCandidates--;
                            if (numOfCandidates == 0) {
                              isCandidatesEmpty = true;
                            }
                            isAddingCandidates = false;

                            print(nameControllers);
                            print(nameControllers.length);
                          });
                        },
                        childText: "Delete",
                        color: CustomStyle.colorPalette.red,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.06),
                    customButton(
                        context: context,
                        onPressed: () {
                          //TODO: add save function
                          print(selectedImages.length);
                          print(selectedImages);
                          bool isNameNull = false;
                          if (nameControllers[nameControllers.length - 1]
                                      .text
                                      .trim() !=
                                  "" ||
                              nameControllers[nameControllers.length - 1]
                                  .text
                                  .trim()
                                  .isNotEmpty) {
                            isNameNull = false;
                          } else {
                            isNameNull = true;
                            showSnackBar("Please add Name", context);
                          }
                          bool isAgeNull = false;
                          if (ageControllers[ageControllers.length - 1]
                                      .text
                                      .trim() !=
                                  "" ||
                              ageControllers[ageControllers.length - 1]
                                  .text
                                  .trim()
                                  .isNotEmpty) {
                            isAgeNull = false;
                          } else {
                            isAgeNull = true;
                            showSnackBar("Please add Age", context);
                          }
                          bool isDescriptionNull = false;
                          if (descriptionControllers[
                                          descriptionControllers.length - 1]
                                      .text
                                      .trim() !=
                                  "" ||
                              descriptionControllers[
                                      descriptionControllers.length - 1]
                                  .text
                                  .trim()
                                  .isNotEmpty) {
                            isDescriptionNull = false;
                          } else {
                            isDescriptionNull = true;
                            showSnackBar("Please add Description", context);
                          }
                          bool isImageNull = false;
                          if (selectedImages.length == numOfCandidates) {
                            isImageNull = false;
                          } else {
                            isImageNull = true;
                            showSnackBar("Please add Image", context);
                          }
                          bool isAgeInt = true;
                          if (int.tryParse(ageController.text.trim()) != null) {
                            isAgeInt = true;
                          } else {
                            isAgeInt = false;

                            showSnackBar("Please enter valid age", context);
                          }
                          if (!isImageNull &&
                              !isAgeNull &&
                              !isDescriptionNull &&
                              !isNameNull &&
                              isAgeInt) {
                            setState(() {
                              isAddingCandidates = false;
                              int timestamp = DateTime.now()
                                  .subtract(Duration(
                                      days: int.parse(ageControllers[
                                                  ageControllers.length - 1]
                                              .text
                                              .trim()) *
                                          365))
                                  .millisecondsSinceEpoch;
                              // call add card function and pass all the requirements
                              candidatesCards.add(Column(
                                children: [
                                  customVerticalSpace(context: context),
                                  CandidateCard(
                                    candidateName: nameControllers[
                                            nameControllers.length - 1]
                                        .text
                                        .trim(),
                                    candidateAge:
                                        "${ageControllers[ageControllers.length - 1].text.trim()}",
                                    candidateDescription:
                                        descriptionControllers[
                                                descriptionControllers.length -
                                                    1]
                                            .text
                                            .trim(),
                                    candidateImage: selectedImages[
                                        selectedImages.length - 1],
                                  ),
                                ],
                              ));

                              candidatesEditingWidget.removeLast();
                            });
                          }
                        },
                        childText: "Save",
                        color: CustomStyle.colorPalette.green,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.06),
                  ],
                ),
                customVerticalSpace(context: context),
              ])),
          customVerticalSpace(context: context),
        ],
      ));
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < nameControllers.length; i++) {
      nameControllers[i].dispose();
    }
    for (int i = 0; i < descriptionControllers.length; i++) {
      descriptionControllers[i].dispose();
    }
    for (int i = 0; i < ageControllers.length; i++) {
      ageControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addCandidate() async {
      nameControllers.add(TextEditingController());
      descriptionControllers.add(TextEditingController());
      ageControllers.add(TextEditingController());
      setState(() {
        numOfCandidates++;
        isAddingCandidates = true;
        isCandidatesEmpty = false;
        candidatesEditingWidget.add(Column(
          children: [
            AutoSizeContainer(
                width: MediaQuery.of(context).size.width * 0.8,
                color: CustomStyle.colorPalette.purple,
                child: Column(children: [
                  customVerticalSpace(context: context),
                  Text(
                    "Please add candidate #$numOfCandidates:",
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
                  ),
                  customVerticalSpace(context: context),
                  GestureDetector(
                      onTap: () async {
                        if (selectedImages.length == numOfCandidates) {
                          selectedImages.removeLast();
                          await _pickImages();
                          print(selectedImages);
                          updatePhoto(
                              nameControllers[nameControllers.length - 1],
                              ageControllers[ageControllers.length - 1],
                              descriptionControllers[
                                  descriptionControllers.length - 1]);
                          setState(() {});
                        } else {
                          await _pickImages();
                          print(selectedImages);
                          updatePhoto(
                              nameControllers[nameControllers.length - 1],
                              ageControllers[ageControllers.length - 1],
                              descriptionControllers[
                                  descriptionControllers.length - 1]);
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: CustomStyle.colorPalette.lightPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: (numOfCandidates == selectedImages.length &&
                                selectedImages.isNotEmpty)
                            ? Image.file(
                                selectedImages.last,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Text("Select photo"),
                              ),
                      )),
                  customVerticalSpace(context: context),
                  Text(
                    "Please add name",
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
                  ),
                  customVerticalSpace(context: context),
                  customTextField(
                      maxLines: 1,
                      textEditingController:
                          nameControllers[nameControllers.length - 1],
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.6,
                      hintText: "Enter Name"),
                  customVerticalSpace(context: context),
                  Text(
                    "Please add age",
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
                  ),
                  customVerticalSpace(context: context),
                  customTextField(
                      maxLines: 1,
                      textEditingController:
                          ageControllers[ageControllers.length - 1],
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.6,
                      hintText: "Enter Age"),
                  customVerticalSpace(context: context),
                  Text(
                    "Please add description",
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.boldFont,
                        fontSize: CustomStyle.fontSizes.mediumFont),
                  ),
                  customVerticalSpace(context: context),
                  customTextField(
                      textEditingController: descriptionControllers[
                          descriptionControllers.length - 1],
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.7,
                      hintText: "Enter Description"),
                  customVerticalSpace(context: context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customButton(
                          context: context,
                          onPressed: () {
                            print(nameControllers.length);

                            setState(() {
                              candidatesEditingWidget
                                  .removeAt(candidatesEditingWidget.length - 1);
                              nameControllers
                                  .removeAt(nameControllers.length - 1);
                              ageControllers
                                  .removeAt(ageControllers.length - 1);
                              descriptionControllers
                                  .removeAt(descriptionControllers.length - 1);
                              if (selectedImages.length == numOfCandidates) {
                                selectedImages
                                    .removeAt(selectedImages.length - 1);
                              }
                              numOfCandidates--;
                              if (numOfCandidates == 0) {
                                isCandidatesEmpty = true;
                              }
                              isAddingCandidates = false;

                              print(nameControllers);
                              print(nameControllers.length);
                            });
                          },
                          childText: "Delete",
                          color: CustomStyle.colorPalette.red,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06),
                      customButton(
                          context: context,
                          onPressed: () {
                            //TODO: add save function
                            print(selectedImages.length);
                            print(selectedImages);
                            bool isNameNull = false;
                            if (nameControllers[nameControllers.length - 1]
                                        .text
                                        .trim() !=
                                    "" ||
                                nameControllers[nameControllers.length - 1]
                                    .text
                                    .trim()
                                    .isNotEmpty) {
                              isNameNull = false;
                            } else {
                              isNameNull = true;
                              showSnackBar("Please add Name", context);
                            }
                            bool isAgeNull = false;
                            if (ageControllers[ageControllers.length - 1]
                                        .text
                                        .trim() !=
                                    "" ||
                                ageControllers[ageControllers.length - 1]
                                    .text
                                    .trim()
                                    .isNotEmpty) {
                              isAgeNull = false;
                            } else {
                              isAgeNull = true;
                              showSnackBar("Please add Age", context);
                            }
                            bool isDescriptionNull = false;
                            if (descriptionControllers[
                                            descriptionControllers.length - 1]
                                        .text
                                        .trim() !=
                                    "" ||
                                descriptionControllers[
                                        descriptionControllers.length - 1]
                                    .text
                                    .trim()
                                    .isNotEmpty) {
                              isDescriptionNull = false;
                            } else {
                              isDescriptionNull = true;
                              showSnackBar("Please add Description", context);
                            }
                            bool isImageNull = false;
                            if (selectedImages.length == numOfCandidates) {
                              isImageNull = false;
                            } else {
                              isImageNull = true;
                              showSnackBar("Please add Image", context);
                            }
                            bool isAgeInt = true;
                            if (int.tryParse(
                                    ageControllers[ageControllers.length - 1]
                                        .text
                                        .trim()) !=
                                null) {
                              isAgeInt = true;
                            } else {
                              isAgeInt = false;

                              showSnackBar("Please enter valid age", context);
                            }
                            if (!isImageNull &&
                                !isAgeNull &&
                                !isDescriptionNull &&
                                !isNameNull &&
                                isAgeInt) {
                              setState(() {
                                isAddingCandidates = false;
                                int timestamp = DateTime.now()
                                    .subtract(Duration(
                                        days: int.parse(ageControllers[
                                                    ageControllers.length - 1]
                                                .text
                                                .trim()) *
                                            365))
                                    .millisecondsSinceEpoch;
                                // call add card function and pass all the requirements
                              });
                            }
                          },
                          childText: "Save",
                          color: CustomStyle.colorPalette.green,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06),
                    ],
                  ),
                  customVerticalSpace(context: context),
                ])),
            customVerticalSpace(context: context),
          ],
        ));
      });
    }

    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.92,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customVerticalSpace(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.05),
                      Image.asset(
                        'assets/images/addCandidates.png',
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                      customVerticalSpace(
                          context: context,
                          height: MediaQuery.of(context).size.height * 0.1),
                      (candidatesCards.isNotEmpty)
                          ? Column(
                              children: candidatesCards,
                            )
                          : SizedBox(),
                      (candidatesCards.isNotEmpty)
                          ? customVerticalSpace(
                              context: context,
                            )
                          : SizedBox(),
                      (isCandidatesEmpty)
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.12,
                              decoration: BoxDecoration(
                                  color: CustomStyle.colorPalette.purple,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                "Add the candidates",
                                style: TextStyle(
                                    fontFamily: CustomStyle.boldFont,
                                    color: CustomStyle.colorPalette.white,
                                    fontSize: CustomStyle.fontSizes.mediumFont),
                              )),
                            )
                          : Column(
                              children: candidatesEditingWidget,
                            ),
                    ]),
              ),
            ),
            customButton(
              context: context,
              onPressed: () {
                //TODO: add navigation and functions
                //Check if is there current editing and if number of candidates is 2 or more
                if (!isAddingCandidates && numOfCandidates >= 2) {
                  for (var i = 0; i < numOfCandidates; i++) {
                    setState(() {
                      candidates.add(Candidate(
                          name: nameControllers[i].text.trim(),
                          photo: selectedImages[i],
                          dateOfBirth: ageControllers[i].text.trim(),
                          description: descriptionControllers[i].text.trim()));
                    });
                  }
                  //TODO: add navigation
                } else if (isAddingCandidates) {
                  showSnackBar("Please finish current candidate", context);
                } else if (numOfCandidates < 2) {
                  showSnackBar("Please add at least two candidates", context);
                }
              },
              childText: "Done",
              color: CustomStyle.colorPalette.lightPurple,
              textStyle: TextStyle(
                color: CustomStyle.colorPalette.darkPurple,
                fontFamily: CustomStyle.boldFont,
                fontSize: CustomStyle.fontSizes.largeFont,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07,
            )
          ],
        ),
      )),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
        child: FloatingActionButton(
          onPressed: () {
            //TODO: add function to add candidates
            if (isAddingCandidates) {
              showSnackBar("Please finish the current candidate", context);
            } else {
              addCandidate();
            }
          },
          child: Icon(
            Icons.add,
            color: CustomStyle.colorPalette.white,
            size: 40,
          ),
          backgroundColor: CustomStyle.colorPalette.purple,
        ),
      ),
    );
  }
}
