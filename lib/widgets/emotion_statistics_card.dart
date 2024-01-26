import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/const.dart';
import '../controllers/history_page_controller.dart';

class EmotionStatisticsCard extends StatelessWidget {
  EmotionStatisticsCard({super.key});

  HistoryPageController historyPageController = Get.find<HistoryPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(
              vertical: Const.screenWidth(context) * 0.02,
              horizontal: Const.screenWidth(context) * 0.04),
          color: const Color.fromARGB(255, 142, 230, 145),
          child: Padding(
            padding: EdgeInsets.all(Const.screenWidth(context) * 0.03),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Emotion Statistics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Const.screenWidth(context) * 0.04,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Const.screenHight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('First Emotion Date',
                            historyPageController.firstEmotionDate.toString(), context),
                        _buildStatItem('Last Emotion Date',
                            historyPageController.lastEmotionDate.toString(), context),
                      ],
                    ),
                    SizedBox(height: Const.screenHight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem('Negative Emotions',
                            historyPageController.negativeEmotionCount.toString(), context),
                        _buildStatItem('Positive Emotions',
                            historyPageController.positiveEmotionCount.toString(), context),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildStatItem(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: Const.screenWidth(context) * 0.035,
          ),
        ),
        SizedBox(height: Const.screenHight(context) * 0.01),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: Const.screenWidth(context) * 0.035,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
