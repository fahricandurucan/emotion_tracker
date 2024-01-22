import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:emotion_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/emotions.gif",
              width: 500,
            ),
          ),
          nextScreen: HomePage(),
          duration: 3000,
          splashTransition: SplashTransition.scaleTransition,
        ),
      ),
    );
  }
}
