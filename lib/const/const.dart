import 'package:flutter/widgets.dart';

class Const {
  static List<String> positiveEmotion = [
    "Joy",
    "Awe",
    "Gratitude",
    "Hope",
    "Amusement",
    "Love",
    "Pride",
    "Satisfaction",
    "Alertness",
  ];

  static List<String> negativeEmotion = [
    "Anger",
    "Anxiety",
    "Contempt",
    "Disgust",
    "Embarrassment",
    "Fear",
    "Quilt",
    "Offense",
    "Sadness"
  ];

  static screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static screenHight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

// Const.dart
class AppColors {
  static const Color textBlackColor = Color(0xff292D32);
  static const Color backgroundColor = Color.fromARGB(255, 243, 243, 243);
  static const Color positiveButtonColor = Color(0xFFAFE6FF);
  static const Color negativeButtonColor = Color(0xFFFF9790);
}

class AppStyles {
  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: Color.fromARGB(255, 65, 66, 68),
  );
}
