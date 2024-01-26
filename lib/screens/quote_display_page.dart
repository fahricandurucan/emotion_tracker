import 'package:emotion_tracker/controllers/quote_display_page_controller.dart';
import 'package:emotion_tracker/widgets/animated_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class QuoteDisplayPage extends StatelessWidget {
  QuoteDisplayPage({super.key});

  final QuoteDisplayPageController quoteDisplayPageController =
      Get.put(QuoteDisplayPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => quoteDisplayPageController.isError.value
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/placeholder.gif",
                  width: Const.screenWidth(context) * 0.2,
                  height: Const.screenWidth(context) * 0.2,
                ),
                SizedBox(
                  height: Const.screenHight(context) * 0.015,
                ),
                const Text(
                  'There are no quotes for this emotion yet.\nHope to see you soon.',
                  textAlign: TextAlign.center,
                ),
              ],
            ))
          : quoteDisplayPageController.quoteList.isEmpty
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Const.screenWidth(context) * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Const.screenWidth(context) * 0.02,
                              vertical: Const.screenWidth(context) * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          quoteDisplayPageController.quoteList.last.emotion,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Const.screenWidth(context) * 0.02,
                              vertical: Const.screenHight(context) * 0.07),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(Const.screenWidth(context) * 0.07),
                                child: AnimatedTextWidget(
                                    text: '"${quoteDisplayPageController.quoteList.last.text}"',
                                    fontSize: 18,
                                    textColor: Colors.white,
                                    letterSpacing: 0.7,
                                    wordSpacing: 0.5,
                                    fontWeight: FontWeight.w400,
                                    milliseconds: 30),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Const.screenWidth(context) * 0.003,
                                    horizontal: Const.screenWidth(context) * 0.04),
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
                  )),
    ));
  }
}
