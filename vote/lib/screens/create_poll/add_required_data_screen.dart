import 'package:flutter/material.dart';
import 'package:vote/custom_components/auto_size_container.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/style/style.dart';

class AddRequiredData extends StatefulWidget {
  const AddRequiredData({Key? key}) : super(key: key);

  @override
  State<AddRequiredData> createState() => _AddRequiredDataState();
}

class _AddRequiredDataState extends State<AddRequiredData> {
  List<TextEditingController> controller = [];
  TextEditingController mainController = TextEditingController();
  String mainInputType = "Choose input";
  List<Widget> rowsOfData = [];
  List<String> inputTypes = [];
  Map<String, String> dataFromUser = {};
  @override
  void dispose() {
    for (int i = 0; i < controller.length; i++) {
      controller[i].dispose();
    }
    mainController.dispose();
    super.dispose();
  }

  void addDataRow(int index) {
    controller.add(TextEditingController());
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
                  textEditingController: controller[controller.length - 1],
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
      controller.removeAt(controller.length - 1);
      rowsOfData.removeAt(rowsOfData.length - 1);
      inputTypes.removeAt(inputTypes.length - 1);
    });
    print(controller.length);
    print(rowsOfData.length);
    print(inputTypes.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          customVerticalSpace(context: context),
                          Container(
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: CustomStyle.colorPalette.lightPurple,
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.13,
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
                                      //TODO: choose input function
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
                                height: 500,
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
                          onPressed: () {
                            if (controller.isNotEmpty ||
                                rowsOfData.isNotEmpty ||
                                inputTypes.isNotEmpty) {
                              removeDataRow();
                            } else {
                              showSnackBar(
                                  "Must be at least one Data to be takken from the user",
                                  context);
                            }
                          },
                          backgroundColor: CustomStyle.colorPalette.purple,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
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
              padding: EdgeInsets.all(16.0),
              child: customButton(
                context: context,
                onPressed: () {
                  bool noEmptyTextFieldsInList = true;
                  bool noEmptyInputTypesInList = true;
                  bool mainTextFieldsNotInList = true;
                  bool mainInputTypesNotInList = true;
                  for (var element in controller) {
                    if (element.text.trim().isEmpty ||
                        element.text.trim() == null ||
                        element.text.trim() == "") {
                      noEmptyTextFieldsInList = false;
                      showSnackBar("Please fill empty Data names", context);
                      print("empty");
                    } else {
                      noEmptyTextFieldsInList = true;
                    }
                  }
                  for (var element in inputTypes) {
                    if (element == "Choose input") {
                      noEmptyInputTypesInList = false;
                      showSnackBar("Please fill empty Input types", context);
                      print("empty");
                    } else {
                      noEmptyInputTypesInList = true;
                      print("####################################not empty");
                    }
                  }
                  if (mainController.text.trim().isEmpty ||
                      mainController.text.trim() == null ||
                      mainController.text.trim() == "") {
                    mainTextFieldsNotInList = false;
                    showSnackBar("Please fill empty Data names", context);
                    print("empty");
                  } else {
                    mainTextFieldsNotInList = true;
                  }
                  if (mainInputType == "Choose input") {
                    mainInputTypesNotInList = false;
                    showSnackBar("Please fill empty Input types", context);
                    print("empty");
                  } else {
                    mainInputTypesNotInList = true;
                  }
                  if (noEmptyInputTypesInList &&
                      noEmptyTextFieldsInList &&
                      mainInputTypesNotInList &&
                      mainTextFieldsNotInList) {
                    //TODO: add next function
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
          onPressed: () {
            addDataRow(rowsOfData.length);
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
                            text = controller[index].text.trim();
                            controller.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);
                            controller.add(TextEditingController());
                            controller[controller.length - 1].text = text;
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
                                          textEditingController:
                                              controller[controller.length - 1],
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
                        Navigator.of(context).pop();

                        print(mainInputType);
                        print(inputTypes);
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
                            text = controller[index].text.trim();
                            controller.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);

                            controller.add(TextEditingController());
                            controller[controller.length - 1].text = text;
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
                                          textEditingController:
                                              controller[controller.length - 1],
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
                        print(mainInputType);

                        print(inputTypes);
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
                            text = controller[index].text.trim();
                            controller.removeAt(index);
                            rowsOfData.removeAt(index);
                            inputTypes.removeAt(index);

                            controller.add(TextEditingController());
                            controller[controller.length - 1].text = text;
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
                                          textEditingController:
                                              controller[controller.length - 1],
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
                        print(mainInputType);

                        print(inputTypes);
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
