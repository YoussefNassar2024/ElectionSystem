import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/custom_components/custom_button.dart';
import 'package:vote/custom_components/custom_space.dart';
import 'package:vote/custom_components/custom_textfield.dart';
import 'package:vote/custom_components/utils.dart';
import 'package:vote/screens/home_screen/home_screen.dart';
import 'package:vote/screens/login_or_signup/password_reset_screen.dart';
import 'package:vote/screens/login_or_signup/sign_up_screen.dart';
import 'package:vote/screens/login_or_signup/vefication_screen.dart';
import 'package:vote/style/style.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final GlobalKey<FormFieldState> emailKey;
  late final GlobalKey<FormFieldState> passwordKey;
  bool passwordVisible = false;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = true;
    emailKey = GlobalKey<FormFieldState>();
    passwordKey = GlobalKey<FormFieldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customVerticalSpace(context: context),
            Center(
              child: Image.asset(
                "assets/images/loginScreen.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Row(
              children: [
                customHorizontalSpace(context: context),
                Text(
                  "Login with email",
                  style: TextStyle(
                      fontSize: CustomStyle.fontSizes.largeFont,
                      fontFamily: CustomStyle.boldFont),
                ),
              ],
            ),
            customVerticalSpace(context: context),
            customHorizontalSpace(context: context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: CustomStyle.fontSizes.largeFont,
                        fontFamily: CustomStyle.boldFont),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      //TODO: add reset password
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const PasswordResetScreen())));
                    },
                    child: Text(
                      "reset password?",
                      style: TextStyle(
                          color: CustomStyle.colorPalette.purple,
                          fontFamily: CustomStyle.boldFont,
                          fontSize: CustomStyle.fontSizes.mediumFont),
                    ))
              ],
            ),
            customVerticalSpace(context: context),
            customTextField(
                key: emailKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!value.contains("@")) {
                    return "Please enter a valid email";
                  } else {
                    List<String> parts = value.split("@");
                    if (parts.length != 2) {
                      return "Please enter a valid email";
                    }

                    String domain = parts[1].toLowerCase();
                    if (!(domain.contains("gmail.com") ||
                        domain.contains("yahoo.com") ||
                        domain.contains("hotmail.com") ||
                        domain.contains("outlook.com"))) {
                      return "Please enter a valid email";
                    }
                  }
                  return null;
                },
                textEditingController: emailController,
                context: context,
                hintText: "Enter your email",
                height: MediaQuery.of(context).size.height * 0.02),
            customVerticalSpace(context: context),
            Row(
              children: [
                customHorizontalSpace(context: context),
                customVerticalSpace(context: context),
                Text(
                  "Password",
                  style: TextStyle(
                      fontSize: CustomStyle.fontSizes.largeFont,
                      fontFamily: CustomStyle.boldFont),
                ),
              ],
            ),
            customVerticalSpace(context: context),
            customTextField(
                maxLines: 1,
                key: passwordKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Password";
                  } else if (value.length < 6) {
                    return "Please enter a longer password";
                  }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                obscureText: passwordVisible,
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  color: Colors.black,
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
                textEditingController: passwordController,
                context: context,
                hintText: "Enter your password",
                height: MediaQuery.of(context).size.height * 0.02),
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      //TODO: Navigate to sign up
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignUnScreen()));
                    },
                    child: Text(
                      "Sign up now!",
                      style: TextStyle(
                          color: CustomStyle.colorPalette.purple,
                          fontFamily: CustomStyle.boldFont,
                          fontSize: CustomStyle.fontSizes.mediumFont),
                    )),
              ),
            ),
            customVerticalSpace(
                context: context,
                height: MediaQuery.of(context).size.height * 0.01),
            customButton(
                context: context,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.07,
                onPressed: () async {
                  if (emailKey.currentState!.validate() &&
                      passwordKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    showLoadingScreen(context);

                    try {
                      // Attempt to sign in with the provided email and password
                      await FireBaseAuthenticationServices.signIn(
                          email, password);

                      // User signed in successfully
                      User? currentUser = FirebaseAuth.instance.currentUser;

                      if (currentUser != null) {
                        // Check if the email is verified
                        await currentUser.reload();
                        currentUser = FirebaseAuth
                            .instance.currentUser; // Refresh user data

                        if (currentUser!.emailVerified) {
                          // Email is verified, navigate to the home screen or another authenticated screen
                          // TODO: Navigate to the home screen
                          removeLoadingScreen(context);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen())); // TODO: add real homescreen
                        } else {
                          // Email not verified, navigate to the verification screen
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const VerificationScreen(),
                            ),
                          );
                        }
                      }
                    } on FirebaseAuthException catch (e) {
                      removeLoadingScreen(context);

                      if (e.code == 'user-not-found') {
                        // User not found, sign up instead
                        try {
                          await FireBaseAuthenticationServices.signUp(
                              email, password, context);

                          // User signed up successfully, send verification email
                          // and navigate to the verification screen
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const VerificationScreen(),
                            ),
                          );
                        } catch (signUpError) {
                          // Handle sign-up errors

                          showSnackBar('Error signing up', context);
                        }
                      } else if (e.code == 'wrong-password') {
                      } else if (e.code == 'invalid-email') {
                        showSnackBar('Invalid email', context);
                      }
                    }
                  }
                },
                childText: "Login"),
            customVerticalSpace(context: context),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  customHorizontalSpace(
                      context: context,
                      width: MediaQuery.of(context).size.width * 0.04),
                  customButton(
                      context: context,
                      onPressed: () {
                        //TODO: add login with google function
                        FireBaseAuthenticationServices.signInWithGoogle();
                        if (user != null) {
                          // User logged in successfully, you can navigate to the next screen or perform other actions.
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } else {
                          showSnackBar("Please Login", context);
                        }
                      },
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.07,
                      childText: "Continue with google")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
