import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vote/screens/login_or_signup/streamer.dart';
import 'package:vote/screens/waiting_screen/widgets/size_config.dart';
import 'package:vote/style/style.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});
  static String ScreenRoute = 'WaitingScreen';
  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  AnimationController? animationController;
  Animation? fadingAnimation;

  @override
  void dispose() {
    _ticker.dispose();
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      animationController?.value = elapsed.inMilliseconds / 1000;
    });
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!)
          ..addListener(() {
            setState(() {
              if (animationController!.isCompleted) {
                animationController?.repeat(reverse: true);
              }
            });
          });
    animationController?.forward();
    try {
      goToNextView();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: CustomStyle.colorPalette.white,
      body: Center(
        child: Opacity(
            opacity: fadingAnimation?.value,
            child: Image.asset("assets/images/logo.jpg")),
      ),
    );
  }

  void goToNextView() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginStreamer()),
      );
    });
  }
}
