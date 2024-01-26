import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/controllers/home_page_controller.dart';
import 'package:emotion_tracker/screens/history_page.dart';
import 'package:emotion_tracker/services/database_helper.dart';
import 'package:emotion_tracker/widgets/animated_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/emotion_button.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Const.SizedBoxHeight(context, 0.07),
              const AnimatedTextWidget(
                  text: "How are you feeling today?",
                  fontSize: 24,
                  textColor: AppColors.textBlackColor,
                  fontWeight: FontWeight.w600,
                  milliseconds: 70),
              Const.SizedBoxHeight(context, 0.1),
              titleEmotion("Positive Emotions", Icons.sentiment_very_satisfied, context),
              buildEmotionList(Const.positiveEmotion, context),
              const SizedBox(height: 50),
              titleEmotion("Negative Emotions", Icons.sentiment_very_dissatisfied, context),
              buildEmotionList(Const.negativeEmotion, context),
              Const.SizedBoxHeight(context, 0.07),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  historyButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmotionList(List<String> emotions, BuildContext context) {
    return SizedBox(
      height: Const.screenHight(context) * 0.22,
      child: PageView.builder(
        controller: homePageController.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: emotions.length,
        itemBuilder: (BuildContext context, int index) {
          return EmotionButton(emotion: emotions[index]);
        },
      ),
    );
  }

  Widget titleEmotion(String title, IconData icon, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Const.screenWidth(context) * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: AppColors.subTitleColor),
          ),
          Const.SizedBoxHeight(context, 0.007),
          Icon(
            icon,
            size: 24,
            color: AppColors.subTitleColor,
          ),
        ],
      ),
    );
  }

  Widget historyButton() {
    return ElevatedButton(
        onPressed: () async {
          DatabaseHelper databaseHelper = DatabaseHelper();
          List<Map<String, dynamic>> emotions = await databaseHelper.getEmotions();
          for (var emotion in emotions) {
            print(
                "Emotion: ${emotion['emotion']}, Timestamp: ${emotion['timestamp']}, Author: ${emotion['author']}");
          }
          Get.to(const HistoryPage());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
        ),
        child: const Text(
          "Show History",
          style: TextStyle(color: AppColors.white),
        ));
  }
}
