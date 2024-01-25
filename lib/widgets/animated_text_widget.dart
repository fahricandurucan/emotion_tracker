import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? letterSpacing;
  final Color textColor;
  final double? wordSpacing;
  final FontWeight fontWeight;
  final int milliseconds;
  const AnimatedTextWidget(
      {super.key,
      required this.text,
      required this.fontSize,
      this.letterSpacing,
      required this.textColor,
      this.wordSpacing,
      required this.fontWeight,
      required this.milliseconds});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: TextStyle(
              fontSize: fontSize,
              color: textColor,
              letterSpacing: letterSpacing ?? 0.7,
              wordSpacing: wordSpacing ?? 0.5,
              fontWeight: fontWeight),
          speed: Duration(milliseconds: milliseconds),
          cursor: "",
          textAlign: TextAlign.center,
        ),
      ],
      totalRepeatCount: 1,
    );
  }
}
