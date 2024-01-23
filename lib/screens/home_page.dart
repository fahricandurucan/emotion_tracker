import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/controllers/home_page_controller.dart';
import 'package:emotion_tracker/services/database_helper.dart';
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
    Color backgroundColor = const Color.fromARGB(255, 243, 243, 243); // Gri tonları

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("How are you feeling today?", style: TextStyle(fontSize: 24)),
              const SizedBox(
                height: 70,
              ),
              titleEmotion("Positive Emotions"),
              buildEmotionList(Const.positiveEmotion),
              const SizedBox(height: 50),
              titleEmotion("Negative Emotions"),
              buildEmotionList(Const.negativeEmotion),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  historyButton(),
                  deleteButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmotionList(List<String> emotions) {
    return SizedBox(
      height: 150,
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

  Widget titleEmotion(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          )
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
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 142, 230, 145), // Arka plan rengi
        ),
        child: const Text(
          "Show History",
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget deleteButton() {
    return ElevatedButton(
        onPressed: () async {
          DatabaseHelper databaseHelper = DatabaseHelper();
          databaseHelper.deleteAllEmotions();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 46, 46), // Arka plan rengi
        ),
        child: const Text(
          "Delete",
          style: TextStyle(color: Colors.white),
        ));
  }
}
