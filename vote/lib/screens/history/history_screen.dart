import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/style/style.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //TODO: add back arrow
        title: Center(
            child: Text(
          "Your Poll History",
          style: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontFamily: CustomStyle.boldFont),
        )),
        backgroundColor: CustomStyle.colorPalette.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customVerticalSpace(context: context),
          Center(child: Image.asset("assets/images/history.png")),
          customVerticalSpace(context: context),
          //TODO: add code to read history and show cards
        ],
      ),
    );
  }
}
