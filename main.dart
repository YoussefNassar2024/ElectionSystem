import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/style/style.dart';

class FillDataScreen extends StatefulWidget {
  const FillDataScreen({super.key, required this.poll});
  final Poll poll;
  @override
  State<FillDataScreen> createState() => _FillDataScreenState();
}

class _FillDataScreenState extends State<FillDataScreen> {
  List<TextEditingController> textEditingcontrollers = [];
  List<TextEditingController> numberEditingcontrollers = [];
  List<File> selectedImages = [];
  List<String> namesOfRequiredImages = [];
  int numberOfRequiredImages = 0;
  int numberofRequiredTexts = 0;
  int numberofRequiredNumbers = 0;
  List<String> namesOfRequiredNumbers = [];
  List<String> namesOfRequiredTexts = [];
  List<GlobalKey<FormFieldState>> formKeyTexts = [];
  List<GlobalKey<FormFieldState>> formKeyNumbers = [];
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _updateImages(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImages[index] = File(pickedFile.path);
      });
    }
  }

  void prepareData() {
    Poll poll = widget.poll;
    for (var i = 0; i < poll.requiredData.length; i++) {
      print(poll.requiredData[i].values.first);
      print(poll.requiredData[i].values.last);
      if (poll.requiredData[i].values.last == "Text") {
        numberofRequiredTexts++;
        textEditingcontrollers.add(TextEditingController());
        formKeyTexts.add(GlobalKey<FormFieldState>());
        namesOfRequiredTexts.add(poll.requiredData[i].values.first);
      } else if (poll.requiredData[i].values.last == "Number") {
        numberofRequiredNumbers++;
        formKeyNumbers.add(GlobalKey<FormFieldState>());
        numberEditingcontrollers.add(TextEditingController());
        namesOfRequiredNumbers.add(poll.requiredData[i].values.first);
      } else if (poll.requiredData[i].values.last == "Image") {
        numberOfRequiredImages++;
        namesOfRequiredImages.add(poll.requiredData[i].values.first);
      }
    }
  }

  bool isDouble(String value) {
    try {
      // Attempt to parse the string as a double
      double.parse(value);
      // If successful, return true
      return true;
    } catch (e) {
      // If an exception occurs, return false
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    prepareData();
    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0; i < textEditingcontrollers.length; i++) {
      textEditingcontrollers[i].dispose();
    }
    for (int i = 0; i < numberEditingcontrollers.length; i++) {
      numberEditingcontrollers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //avoid floating button to raise when keyboard is raised
      appBar: AppBar(
        backgroundColor: CustomStyle.colorPalette.purple,
        title: Center(
          child: Text(
            "Fill the Data",
            style: TextStyle(
                color: CustomStyle.colorPalette.white,
                fontFamily: CustomStyle.boldFont,
                fontSize: CustomStyle.fontSizes.largeFont),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: CustomStyle.colorPalette.purple,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        customVerticalSpace(context: context),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: numberofRequiredTexts,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          namesOfRequiredTexts[index],
                                          style: TextStyle(
                                              fontFamily: CustomStyle.boldFont,
                                              color: CustomStyle
                                                  .colorPalette.white,
                                              fontSize: CustomStyle
                                                  .fontSizes.largeFont),
                                        )),
                                  ),
                                  customVerticalSpace(context: context),
                                  customTextField(
                                      key: formKeyTexts[index],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        }
                                      },
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      textEditingController:
                                          textEditingcontrollers[index],
                                      context: context),
                                  customVerticalSpace(context: context),
                                ],
                              );
                            })),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: numberofRequiredNumbers,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          namesOfRequiredNumbers[index],
                                          style: TextStyle(
                                              fontFamily: CustomStyle.boldFont,
                                              color: CustomStyle
                                                  .colorPalette.white,
                                              fontSize: CustomStyle
                                                  .fontSizes.largeFont),
                                        )),
                                  ),
                                  customVerticalSpace(context: context),
                                  customTextField(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      key: formKeyNumbers[index],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return null;
                                        } else if (!isDouble(
                                            value.toString())) {
                                          return "Please enter the numric data";
                                        }
                                      },
                                      textEditingController:
                                          numberEditingcontrollers[index],
                                      context: context),
                                  customVerticalSpace(context: context),
                                ],
                              );
                            })),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: numberOfRequiredImages,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.1),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          namesOfRequiredImages[index],
                                          style: TextStyle(
                                              fontFamily: CustomStyle.boldFont,
                                              color: CustomStyle
                                                  .colorPalette.white,
                                              fontSize: CustomStyle
                                                  .fontSizes.largeFont),
                                        )),
                                  ),
                                  customVerticalSpace(context: context),
                                  Container(
                                    color: CustomStyle.colorPalette.lightPurple,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: GestureDetector(
                                      child: (index >= 0 &&
                                              index < selectedImages.length)
                                          ? Image.file(
                                              selectedImages[index],
                                              fit: BoxFit.cover,
                                            )
                                          : Center(
                                              child:
                                                  Text("Please select photo")),
                                      onTap: () async {
                                        if (index >= 0 &&
                                            index < selectedImages.length) {
                                          await _updateImages(index);
                                        } else {
                                          await _pickImages();
                                        }
                                      },
                                    ),
                                  ),
                                  customVerticalSpace(context: context),
                                ],
                              );
                            })),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: customButton(
          context: context,
          color: CustomStyle.colorPalette.lightPurple,
          textStyle: TextStyle(
              color: CustomStyle.colorPalette.darkPurple,
              fontFamily: CustomStyle.boldFont,
              fontSize: CustomStyle.fontSizes.largeFont),
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.7,
          onPressed: () {
            //TODO: add navigation
            Map<String, dynamic> voterData = {};
            bool validNumricData = true;
            bool validTextData = true;
            bool imagesAreAdded = true;
            for (var element in formKeyTexts) {
              if (!element.currentState!.validate()) {
                validTextData = false;
              }
            }
            if (!validTextData) {
              showSnackBar("Please enter all required data", context);
            }
            for (var element in formKeyNumbers) {
              if (!element.currentState!.validate()) {
                validNumricData = false;
              }
            }
            if (!validNumricData) {
              showSnackBar("Please enter all required data", context);
            }
            if (numberOfRequiredImages != selectedImages.length) {
              imagesAreAdded = false;
              showSnackBar("Please add all required images", context);
            }
            if (validTextData && validNumricData && imagesAreAdded) {
              for (var i = 0; i < textEditingcontrollers.length; i++) {
                //add users data
                voterData.addAll({
                  "${namesOfRequiredTexts[i]}":
                      textEditingcontrollers[i].text.trim()
                });
              }
              for (var i = 0; i < numberEditingcontrollers.length; i++) {
                voterData.addAll({
                  "${namesOfRequiredNumbers[i]}":
                      numberEditingcontrollers[i].text.trim()
                });
              }
              for (var i = 0; i < selectedImages.length; i++) {
                voterData
                    .addAll({"${namesOfRequiredImages[i]}": selectedImages[i]});
              }
              //TODO: pass the voterdata map and poll from widget
              // Navigator.of(context).push(MaterialPageRoute(builder: ((context) => NextPage()));
            }
          },
          childText: "Done"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
