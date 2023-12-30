import 'package:flutter/material.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/style/style.dart';

class VoteDoneScreen extends StatelessWidget {
  const VoteDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              '"C:\Users\Dell\Desktop\amira\Screenshot 2023-12-30 122259.png"',
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Vote Submitted!',
            style: TextStyle(
              fontFamily: CustomStyle.boldFont,
              fontSize: CustomStyle.fontSizes.largeFont,
              color: CustomStyle.colorPalette.darkPurple,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: CustomStyle.colorPalette.lightPurple,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 15.0,
              ),
            ),
            child: Text(
              'Back to Home',
              style: TextStyle(
                fontFamily: CustomStyle.boldFont,
                fontSize: CustomStyle.fontSizes.mediumFont,
                color: CustomStyle.colorPalette.darkPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
