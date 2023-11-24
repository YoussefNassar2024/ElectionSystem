import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/style/style.dart';

class AddCandidatesScreen extends StatefulWidget {
  @override
  State<AddCandidatesScreen> createState() => _AddCandidatesScreenState();
}

class _AddCandidatesScreenState extends State<AddCandidatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        customVerticalSpace(
            context: context,
            height: MediaQuery.of(context).size.height * 0.05),
        Image.asset(
          'assets/images/addCandidates.png',
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        customVerticalSpace(
            context: context, height: MediaQuery.of(context).size.height * 0.1),
        Container(
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
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO: add function to add candidates
        },
        backgroundColor: CustomStyle.colorPalette.purple,
        child: Icon(Icons.add),
      ),
    );
  }
}
