import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote/Services/poll_services.dart';
import 'package:vote/Services/results_services.dart';
import 'package:vote/Services/storage_services.dart';
import 'package:vote/Services/user_services.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/models/poll_model.dart';
import 'package:vote/models/results_model.dart';
import 'package:vote/screens/create_poll/poll_code_screen.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/style/style.dart';

class DeadLinePickerScreen extends StatefulWidget {
  const DeadLinePickerScreen({
    super.key,
    required this.pollName,
    required this.candidates,
    required this.dataFromUser,
    required this.candidatesPhotos,
  });
  final String pollName;
  final List<File> candidatesPhotos;
  final List<Candidate> candidates;
  final List<Map<String, String>> dataFromUser;
  @override
  State<DeadLinePickerScreen> createState() => _DeadLinePickerScreenState();
}

class _DeadLinePickerScreenState extends State<DeadLinePickerScreen> {
  String selectedDay = '1';
  String selectedMonth = 'January';
  String selectedYear = '2024';
  List<String?> photosUrl = [];
  List<Map<String, dynamic>> resultsToBeUploaded = [];
  List<String> days = List.generate(31, (index) => (index + 1).toString());
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  List<String> monthsHave31Days = [
    'January',
    'March',
    'May',
    'July',
    'August',
    'October',
    'December'
  ];
  List<String> years = [];
  List<String> yearsHave29DaysInFeb = [];
  bool isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          yearsHave29DaysInFeb.add(year.toString());
        }
      } else {
        yearsHave29DaysInFeb.add(year.toString());
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    int currentYearNow = DateTime.now().year;
    for (var i = 0; i <= 10; i++) {
      if (isLeapYear(currentYearNow)) {
        yearsHave29DaysInFeb.add(currentYearNow.toString());
      }
      currentYearNow++;
    }
    print(isLeapYear(2022));

    int currentYear = DateTime.now().year;
    int endWhileLoop = currentYear + 10;
    while (currentYear != endWhileLoop) {
      years.add(currentYear.toString());
      currentYear++;
    }
    print(years);
    print(yearsHave29DaysInFeb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.05),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/deadline.png',
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.05),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: CustomStyle.colorPalette.lightPurple,
                    borderRadius: BorderRadius.circular(7)),
                height: MediaQuery.of(context).size.height * 0.055,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Center(
                    child: Text(
                  "Pick deadline for the poll",
                  style: TextStyle(
                      fontFamily: CustomStyle.boldFont,
                      fontSize: CustomStyle.fontSizes.mediumFont),
                )),
              ),
            ),
          ),
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Day",
                style: TextStyle(
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              ),
              Text(
                "Month",
                style: TextStyle(
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              ),
              Text(
                "Year",
                style: TextStyle(
                    fontFamily: CustomStyle.boldFont,
                    fontSize: CustomStyle.fontSizes.mediumFont),
              )
            ],
          ),
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DecoratedBox(
                decoration: ShapeDecoration(
                    color: CustomStyle.colorPalette.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: selectedDay,
                    items: days.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDay = newValue!;
                      });
                    },
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.semiBoldFont),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 30,
                    ),
                    dropdownColor: CustomStyle.colorPalette.purple,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: ShapeDecoration(
                    color: CustomStyle.colorPalette.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: selectedMonth,
                    items: months.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.semiBoldFont),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 30,
                    ),
                    dropdownColor: CustomStyle.colorPalette.purple,
                  ),
                ),
              ),
              DecoratedBox(
                decoration: ShapeDecoration(
                    color: CustomStyle.colorPalette.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: DropdownButton<String>(
                    value: selectedYear,
                    items: years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    style: TextStyle(
                        color: CustomStyle.colorPalette.white,
                        fontFamily: CustomStyle.semiBoldFont),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 30,
                    ),
                    dropdownColor: CustomStyle.colorPalette.purple,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: customButton(
                context: context,
                color: CustomStyle.colorPalette.lightPurple,
                textStyle: TextStyle(
                  color: CustomStyle.colorPalette.darkPurple,
                  fontFamily: CustomStyle.boldFont,
                  fontSize: CustomStyle.fontSizes.largeFont,
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                onPressed: () async {
                  bool valid = true;
                  // Check for days in February for leap years
                  if (selectedMonth == "February") {
                    if (yearsHave29DaysInFeb.contains(selectedYear)) {
                      if (selectedDay == "30" || selectedDay == '31') {
                        valid = false;
                      }
                    } else {
                      if (selectedDay == '29' ||
                          (selectedDay == '30' &&
                              !yearsHave29DaysInFeb.contains(selectedYear))) {
                        valid = false;
                      }
                    }
                  } else if (!monthsHave31Days.contains(selectedMonth) &&
                      (selectedDay == "31")) {
                    valid = false;
                  }
                  // Check if the selected date is not the current date
                  DateTime currentDate = DateTime.now();
                  DateTime selectedDate = DateTime(
                      int.parse(selectedYear),
                      months.indexOf(selectedMonth) + 1,
                      int.parse(selectedDay));
                  Timestamp selectedDateTimeStamp =
                      Timestamp.fromDate(selectedDate);
                  if (selectedDate.isBefore(currentDate) ||
                      selectedDate.isAtSameMomentAs(currentDate)) {
                    valid = false;
                  }
                  String pollCode = generateUniqueID();
                  print(valid);
                  if (valid) {
                    print("Valid date. Implement navigation or other actions.");
                    //TODO: add navigation and upload
                    try {
                      showLoadingScreen(context);
                      for (var i = 0; i < widget.candidatesPhotos.length; i++) {
                        photosUrl.add(
                            await StorageServices.uploadImageToStorage(
                                widget.candidatesPhotos[i], pollCode));
                      }
                      for (var i = 0; i < photosUrl.length; i++) {
                        setState(() {
                          widget.candidates[i].photo = photosUrl[i]!;
                        });
                      }
                      await PollService.createPoll(
                          pollCode,
                          Poll(
                              requiredData: widget.dataFromUser,
                              candidates: widget.candidates,
                              pollCode: pollCode,
                              pollExpiryDate: selectedDateTimeStamp,
                              pollFinished: false,
                              title: widget.pollName));
                      for (var i = 0; i < widget.candidates.length; i++) {
                        resultsToBeUploaded
                            .add({"${widget.candidates[i].Id}": 0});
                      }
                      await ResultsService.uploadResults(pollCode,
                          Results(candidateResults: resultsToBeUploaded));
                      await UserService.addCreatedPoll(pollCode);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => PollCodeScreen(
                                pollCode: pollCode,
                              )));
                    } on Exception catch (e) {
                      showSnackBar(e.toString(), context);
                    }
                  } else {
                    print("Invalid date. Handle the case accordingly.");
                    showSnackBar("Please enter a valid date", context);
                  }
                },
                childText: "Done"),
          )
        ],
      ),
    );
  }
}

String generateUniqueID() {
  DateTime now = DateTime.now();

  // Format the date and time to create a unique ID
  String formattedDate =
      "${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}";
  String formattedTime =
      "${_twoDigits(now.hour)}${_twoDigits(now.minute)}${_twoDigits(now.second)}";
  String uniqueID = "$formattedDate$formattedTime";
  print(uniqueID);
  return uniqueID;
}

String _twoDigits(int n) {
  // Helper function to ensure two digits for month, day, hour, minute, and second
  return n.toString().padLeft(2, '0');
}
