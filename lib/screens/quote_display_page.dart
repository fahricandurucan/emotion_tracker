import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:emotion_tracker/controllers/quote_display_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuoteDisplayPage extends StatelessWidget {
  QuoteDisplayPage({super.key});

  final QuoteDisplayPageController quoteDisplayPageController =
      Get.put(QuoteDisplayPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => quoteDisplayPageController.quote.value.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                image: quoteDisplayPageController.imglink.value.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage("assets/${quoteDisplayPageController.imglink.value}"),
                        fit: BoxFit.fill,
                        colorFilter:
                            ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                      )
                    : null,
              ),
              child: Container(
                // color: Colors.pink,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        quoteDisplayPageController.quoteList.last.emotion,
                        style: const TextStyle(
                            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    '"${quoteDisplayPageController.quoteList.last.text}"',
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        letterSpacing: 0.7,
                                        wordSpacing: 0.5,
                                        fontWeight: FontWeight.w400),
                                    speed: const Duration(milliseconds: 30),
                                    cursor: "",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                totalRepeatCount: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "~${quoteDisplayPageController.quoteList.last.author}~",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16, letterSpacing: 0.7),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    ));
  }
}
