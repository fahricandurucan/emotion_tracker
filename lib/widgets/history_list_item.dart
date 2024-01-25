import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';

class HistoryListItem extends StatelessWidget {
  Map<String, dynamic> emotion;
  HistoryListItem({super.key, required this.emotion});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(
          vertical: Const.screenWidth(context) * 0.02,
          horizontal: Const.screenWidth(context) * 0.04),
      color: Const.positiveEmotion.contains(emotion["emotion"])
          ? const Color.fromARGB(255, 175, 230, 255)
          : const Color.fromARGB(255, 255, 151, 144),
      child: ListTile(
        title: Text(
          emotion["emotion"],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          _formatTimeStamp(emotion["timestamp"]),
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        onTap: () {
          // Tıklanabilir olduğunda ek bir işlev ekleyebilirsiniz
        },
      ),
    );
  }

  String _formatTimeStamp(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }
}
