import 'package:animated_splash_screen/animated_splash_screen.dart';
import "package:flutter/material.dart";
import 'package:medory/main.dart';
import 'package:medory/widgets/terms_and_conditions.dart';

class Splash extends StatelessWidget {
  Splash({super.key});

  Future<void> waitAndPushRoute(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TermsAndConditions(
        termAndConditionItems: [],
        title: "",
      );
    }));
  }

  @override
  Widget build(context) {
    waitAndPushRoute(context);
    return AnimatedSplashScreen(
        duration: 1500,
        splash: Container(
          width: 236,
          height: 635,
          color: Colors.white,
          child: Center(
            child: Image.asset('assets/images/logo.jpg'),
          ),
        ),
        nextScreen: const MyHomePage(
          title: "Medory",
        ));
  }
}
