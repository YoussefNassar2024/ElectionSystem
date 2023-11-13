import 'package:flutter/material.dart';
import 'package:vote/style/style.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void showLoadingScreen(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Container(
        color: const Color.fromARGB(131, 255, 255, 255),
        child: Center(
          child: CircularProgressIndicator(
            color: CustomStyle.colorPalette.purple,
          ),
        ),
      );
    },
  );
}

void removeLoadingScreen(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

void showSnackBar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(
        text,
      )));
}
