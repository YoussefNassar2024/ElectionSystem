import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/screens/create_poll/dead_line_picker_screen.dart';
import 'package:vote/style/style.dart';

class AddRequiredData extends StatefulWidget {
  const AddRequiredData(
      {Key? key,
      required this.pollName,
      required this.candidates,
      required this.candidatesimages})
      : super(key: key);
  final String pollName;
  final List<Candidate> candidates;
  final List<File> candidatesimages;
  @override
  State<AddRequiredData> createState() => _AddRequiredDataState();
}

class _AddRequiredDataState extends State<AddRequiredData> {
  List<TextEditingController> dataNameController = [];
  TextEditingController mainController = TextEditingController();
  String mainInputType = "Choose input";
  List<Widget> rowsOfData = [];
  List<String> inputTypes = [];
  List<Map<String, String>> dataFromUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFromUser.clear();
  }

  @override
  void dispose() {
    for (int i = 0; i < dataNameController.length; i++) {
      dataNameController[i].dispose();
    }
    mainController.dispose();
    super.dispose();
  }

  void addDataRow(int index) {
    dataNameController.add(TextEditingController());
    inputTypes.add("Choose input");
    setState(() {
      rowsOfData.add(
        Column(
          children: [
            customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.017,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customTextField(
                  maxLines: 1,
                  textEditingController:
                      dataNameController[dataNameController.length - 1],
                  context: context,
                  hintText: "Data name",
                  height: MediaQuery.of(context).size.height * 0.013,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                customButton(
                  context: context,
                  onPressed: () {
                    _showPopup(context, index, true);
                  },
                  childText: inputTypes[index],
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.06,
                  color: CustomStyle.colorPalette.lightPurple,
                  textStyle: TextStyle(
                    color: CustomStyle.colorPalette.darkPurple,
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  void removeDataRow() {
    setState(() {
      dataNameController.removeAt(dataNameController.length - 1);
      rowsOfData.removeAt(rowsOfData.length - 1);
      inputTypes.removeAt(inputTypes.length - 1);
      dataFromUser.removeLast();
    });
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
            "Add Required Data",
            style: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontFamily: CustomStyle.boldFont,
            ),
          ),
        ),
        backgroundColor: CustomStyle.colorPalette.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.81,
              child: SingleChildScrollView(
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          customVerticalSpace(context: context),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomStyle.colorPalette.lightPurple,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "You can select the input type and add name to the data to be collected from the user",
                                style: TextStyle(
                                  fontFamily: CustomStyle.boldFont,
                                  fontSize: CustomStyle.fontSizes.largeFont,
                                ),
                              ),
                            ),
                          ),
                          customVerticalSpace(context: context),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Data",
                                    style: TextStyle(
                                      fontFamily: CustomStyle.boldFont,
                                      fontSize: CustomStyle.fontSizes.largeFont,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    child: Text(
                                      "Input Type",
                                      style: TextStyle(
                                        fontFamily: CustomStyle.boldFont,
                                        fontSize:
                                            CustomStyle.fontSizes.largeFont,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              customVerticalSpace(
                                context: context,
                                height:
                                    MediaQuery.of(context).size.height * 0.017,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  customTextField(
                                    maxLines: 1,
                                    textEditingController: mainController,
                                    context: context,
                                    hintText: "Data name",
                                    height: MediaQuery.of(context).size.height *
                                        0.013,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                  ),
                                  customButton(
                                    context: context,
                                    onPressed: () {
                                      _showPopup(context, 0, false);
                                    },
                                    childText: mainInputType,
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    color: CustomStyle.colorPalette.lightPurple,
                                    textStyle: TextStyle(
                                      color:
                                          CustomStyle.colorPalette.darkPurple,
                                      fontFamily: CustomStyle.boldFont,
                                      fontSize:
                                          CustomStyle.fontSizes.mediumFont,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: ListView.builder(
                                    itemCount: rowsOfData.length,
                                    itemBuilder: (context, index) {
                                      return rowsOfData[index];
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.73,
                            left: MediaQuery.of(context).size.width * 0.034),
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          onPressed: () async {
                            if (dataNameController.isNotEmpty ||
                                rowsOfData.isNotEmpty ||
                                inputTypes.isNotEmpty) {
                              setState(() {
                                removeDataRow();
                              });
                            } else {
                              showSnackBar(
                                  "Must be at least one Data to be takken from the user",
                                  context);
                            }
                          },
                          backgroundColor: CustomStyle.colorPalette.purple,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Icon(
                              Icons.remove,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: customButton(
                context: context,
                onPressed: () {
                  bool noEmptyTextFieldsInList = true;
                  bool noEmptyInputTypesInList = true;
                  bool mainTextFieldsNotInList = true;
                  bool mainInputTypesNotInList = true;
                  for (var element in dataNameController) {
                    if (element.text.trim().isEmpty ||
                        element.text.trim() == "") {
                      noEmptyTextFieldsInList = false;
                      showSnackBar("Please fill empty Data names", context);
                    } else {
                      noEmptyTextFieldsInList = true;
                    }
                  }
                  for (var element in inputTypes) {
                    if (element == "Choose input") {
                      noEmptyInputTypesInList = false;
                      showSnackBar("Please fill empty Input types", context);
                    } else {
                      noEmptyInputTypesInList = true;
                    }
                  }
                  if (mainController.text.trim().isEmpty ||
                      mainController.text.trim() == "") {
                    mainTextFieldsNotInList = false;
                    showSnackBar("Please fill empty Data names", context);
                  } else {
                    mainTextFieldsNotInList = true;
                  }
                  if (mainInputType == "Choose input") {
                    mainInputTypesNotInList = false;
                    showSnackBar("Please fill empty Input types", context);
                  } else {
                    mainInputTypesNotInList = true;
                  }
                  if (noEmptyInputTypesInList &&
                      noEmptyTextFieldsInList &&
                      mainInputTypesNotInList &&
                      mainTextFieldsNotInList) {
                    dataFromUser.add({
                      'data name': mainController.text.trim(),
                      'data type': mainInputType
                    });
                    for (var i = 0; i < inputTypes.length; i++) {
                      dataFromUser.add({
                        "data name": dataNameController[i].text.trim(),
                        "data type": inputTypes[i]
                      });
                    }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeadLinePickerScreen(
                              candidatesPhotos: widget.candidatesimages,
                              pollName: widget.pollName,
                              candidates: widget.candidates,
                              dataFromUser: dataFromUser,
                            )));
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
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        child: FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () {
            addDataRow(rowsOfData.length);
          },
          backgroundColor: CustomStyle.colorPalette.purple,
          child: Icon(
            Icons.add,
            color: CustomStyle.colorPalette.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context, int index, bool inList) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Center(
          child: AlertDialog(
            backgroundColor: CustomStyle.colorPalette.lightPurple,
            title: Text(
              'Choose input type',
              style: TextStyle(
                  color: CustomStyle.colorPalette.darkPurple,
                  fontFamily: CustomStyle.boldFont),
            ),
            content: IntrinsicHeight(
              child: Column(
                children: [
                  customButton(
                      context: context,
                      onPressed: () {
                        setState(() {
                          if (inList) {
                            String text;
                            text = dataNameController[index].text.trim();
                            dataNameController.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);
                            dataNameController.add(TextEditingController());
                            dataNameController[dataNameController.length - 1]
                                .text = text;
                            inputTypes.add("Text");
                            setState(() {
                              rowsOfData.add(
                                Column(
                                  children: [
                                    customVerticalSpace(
                                      context: context,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.017,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customTextField(
                                          maxLines: 1,
                                          textEditingController:
                                              dataNameController[
                                                  dataNameController.length -
                                                      1],
                                          context: context,
                                          hintText: "Data name",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.013,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                        ),
                                        customButton(
                                          context: context,
                                          onPressed: () {
                                            _showPopup(context, index, true);
                                          },
                                          childText: "Text",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          color: CustomStyle
                                              .colorPalette.lightPurple,
                                          textStyle: TextStyle(
                                            color: CustomStyle
                                                .colorPalette.darkPurple,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.mediumFont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                            inputTypes[index] = "Text";
                          } else {
                            mainInputType = "Text";
                          }
                        });
                        Navigator.of(dialogContext, rootNavigator: true).pop();
                      },
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      childText: "Text"),
                  customVerticalSpace(
                    context: context,
                    height: MediaQuery.of(context).size.height * 0.017,
                  ),
                  customButton(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      onPressed: () {
                        setState(() {
                          if (inList) {
                            String text;
                            text = dataNameController[index].text.trim();
                            dataNameController.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);

                            dataNameController.add(TextEditingController());
                            dataNameController[dataNameController.length - 1]
                                .text = text;
                            inputTypes.add("Number");
                            setState(() {
                              rowsOfData.add(
                                Column(
                                  children: [
                                    customVerticalSpace(
                                      context: context,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.017,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customTextField(
                                          maxLines: 1,
                                          textEditingController:
                                              dataNameController[
                                                  dataNameController.length -
                                                      1],
                                          context: context,
                                          hintText: "Data name",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.013,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                        ),
                                        customButton(
                                          context: context,
                                          onPressed: () {
                                            _showPopup(context, index, true);
                                          },
                                          childText: "Number",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          color: CustomStyle
                                              .colorPalette.lightPurple,
                                          textStyle: TextStyle(
                                            color: CustomStyle
                                                .colorPalette.darkPurple,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.mediumFont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                            inputTypes[index] = "Number";
                          } else {
                            mainInputType = "Number";
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      childText: "Number"),
                  customVerticalSpace(
                    context: context,
                    height: MediaQuery.of(context).size.height * 0.017,
                  ),
                  customButton(
                      context: context,
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      onPressed: () {
                        setState(() {
                          if (inList) {
                            String text;
                            text = dataNameController[index].text.trim();
                            dataNameController.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);

                            dataNameController.add(TextEditingController());
                            dataNameController[dataNameController.length - 1]
                                .text = text;
                            inputTypes.add("Image");
                            setState(() {
                              rowsOfData.add(
                                Column(
                                  children: [
                                    customVerticalSpace(
                                      context: context,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.017,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        customTextField(
                                          maxLines: 1,
                                          textEditingController:
                                              dataNameController[
                                                  dataNameController.length -
                                                      1],
                                          context: context,
                                          hintText: "Data name",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.013,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                        ),
                                        customButton(
                                          context: context,
                                          onPressed: () {
                                            _showPopup(context, index, true);
                                          },
                                          childText: "Image",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          color: CustomStyle
                                              .colorPalette.lightPurple,
                                          textStyle: TextStyle(
                                            color: CustomStyle
                                                .colorPalette.darkPurple,
                                            fontFamily: CustomStyle.boldFont,
                                            fontSize: CustomStyle
                                                .fontSizes.mediumFont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                            inputTypes[index] = "Image";
                          } else {
                            mainInputType = "Image";
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      childText: "Image")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
