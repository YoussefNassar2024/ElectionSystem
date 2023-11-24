import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/screens/login_or_signup/sign_in_screen.dart';
import 'package:vote/style/style.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isEmailSent = false;
  Color? buttonColor = CustomStyle.colorPalette.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
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
              isEmailSent
                  ? "Password reset email sent! Check your inbox."
                  : "Enter your email to reset the password.",
              style: TextStyle(
                fontSize: CustomStyle.fontSizes.largeFont,
                fontFamily: CustomStyle.boldFont,
              ),
            ),
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.05),
            customTextField(
                textEditingController: _emailController,
                context: context,
                hintText: "Enter your email",
                height: MediaQuery.of(context).size.height * 0.02),
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.09),
            customButton(
              context: context,
              borderRadius: 5,
              color: buttonColor,
              width: MediaQuery.of(context).size.width * 0.7,
              onPressed: () async {
                try {
                  FireBaseAuthenticationServices.passwordReset(
                      _emailController.text.trim(), context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                } on FirebaseAuthException catch (e) {
                  String errorMessage = "Failed to send password reset email.";
                  if (e.code == 'user-not-found') {
                    errorMessage =
                        "User not found. Please check the email address.";
                  }
                  showSnackBar(errorMessage, context);
                }
              },
              childText:
                  isEmailSent ? "Return to Login" : "Send Password Reset Email",
            ),
          ],
        ),
      ),
    );
  }
}
