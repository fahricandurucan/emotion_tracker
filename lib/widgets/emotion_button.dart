import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/controllers/quote_display_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/quote_display_page.dart';

class EmotionButton extends StatelessWidget {
  final String emotion;

  EmotionButton({Key? key, required this.emotion}) : super(key: key);

  final QuoteDisplayPageController quoteDisplayPageController =
      Get.put(QuoteDisplayPageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Const.screenWidth(context) * 0.36,
      height: Const.screenHight(context) * 0.22,
      padding: EdgeInsets.all(Const.screenWidth(context) * 0.01),
      margin: EdgeInsets.all(Const.screenWidth(context) * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () async {
          // send notification

          quoteDisplayPageController.fetchQuote(emotion);
          Get.to(QuoteDisplayPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Const.positiveEmotion.contains(emotion)
              ? AppColors.positiveButtonColor
              : AppColors.negativeButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 5,
        ),
        child: Text(
          emotion,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
