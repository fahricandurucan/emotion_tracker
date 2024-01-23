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
      width: 150, // İstediğiniz boyutu ayarlayabilirsiniz
      height: 150, // İstediğiniz boyutu ayarlayabilirsiniz
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // border: Border.all(
        //   color: Colors.black, // Kenar rengini ayarlayabilirsiniz
        // ),
        boxShadow: [
          BoxShadow(
            color: Const.positiveEmotion.contains(emotion)
                ? const Color.fromARGB(255, 222, 244, 255)
                : const Color.fromARGB(255, 255, 223, 220),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1), // gölge konumu
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          quoteDisplayPageController.fetchQuote(emotion);
          Get.to(QuoteDisplayPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Const.positiveEmotion.contains(emotion)
              ? const Color.fromARGB(255, 175, 230, 255)
              : const Color.fromARGB(
                  255, 255, 151, 144), // Olumlu ve olumsuz duyguları renklendirmek için kontrol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          emotion,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
