import 'dart:async';

import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/screens/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Const.screenWidth(context) * 0.3,
              height: Const.screenWidth(context) * 0.3,
              child: Image.asset(
                "assets/emotions.gif",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: Const.screenWidth(context) * 0.02,
            ),
            const Text(
              "EMOTION TRACKER",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff292D32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
