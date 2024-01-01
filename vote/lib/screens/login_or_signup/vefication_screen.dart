import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/style/style.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  int remainingSeconds = 30;
  Color? buttonColor = CustomStyle.colorPalette.purple;

  @override
  void initState() {
    super.initState();

    sendVerificationEmail();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTimer());

    Timer.periodic(const Duration(seconds: 5), (_) {
      checkEmailVerified();
    });
    updateTimer();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      if (mounted) {
        setState(() {
          canResendEmail = false;
          buttonColor = CustomStyle.colorPalette.lightPurple;
        });
      }
      for (int i = 0; i < 60; i++) {
        // Delay for 1 second
        await Future.delayed(const Duration(seconds: 1));
      }
      if (mounted) {
        setState(() {
          canResendEmail = true;
          buttonColor = CustomStyle.colorPalette.purple;
        });
      }
    } on Exception {
      showSnackBar(
          "You have reached the limit, please try again later", context);
    }
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (mounted) {
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });
    }
    if (isEmailVerified) {
      timer?.cancel();
      if (mounted) {
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen()), // Replace HomeScreen with your actual home screen widget
        );
      }
    }
  }

  void updateTimer() {
    if (remainingSeconds > 0) {
      if (mounted) {
        setState(() {
          remainingSeconds--;
        });
      }
    } else {
      timer?.cancel();
      if (mounted) {
        setState(() {
          canResendEmail = true;
          buttonColor = CustomStyle.colorPalette.purple;
        });
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.15),
          Center(
            child: Image.asset(
              "assets/images/verfication.png",
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          customVerticalSpace(
              context: context,
              height: MediaQuery.of(context).size.height * 0.1),
          Text(
            "Please check your email for verification!",
            style: TextStyle(
              fontSize: CustomStyle.fontSizes.largeFont,
              fontFamily: CustomStyle.boldFont,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: customButton(
                context: context,
                borderRadius: 5,
                color: buttonColor,
                width: MediaQuery.of(context).size.width * 0.7,
                onPressed: () {
                  if (canResendEmail) {
                    sendVerificationEmail();
                    if (mounted) {
                      setState(() {
                        canResendEmail = false;
                        buttonColor = CustomStyle.colorPalette.lightPurple;
                        remainingSeconds = 30;
                        timer = Timer.periodic(
                            const Duration(seconds: 1), (_) => updateTimer());
                      });
                    }
                  }
                },
                childText: (canResendEmail)
                    ? "Send Verification Email"
                    : "Please wait $remainingSeconds"),
          ),
        ],
      ),
    );
  }
}
