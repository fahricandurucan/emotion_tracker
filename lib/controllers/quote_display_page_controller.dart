import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:emotion_tracker/models/quote.dart';
import 'package:emotion_tracker/notification/notification_service.dart';
import 'package:emotion_tracker/services/database_helper.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class QuoteDisplayPageController extends GetxController {
  final quote = "".obs;
  final imglink = "".obs;
  final String _apiKey = '00fa553d76e5afea18e8d00a83c45619'; // my api key
  final isError = false.obs;

  List<Quote> quoteList = <Quote>[].obs;

  Rx<Quote> quoteModel = Quote(emotion: "", timestamp: "", text: "", author: "").obs;

  Future<void> fetchQuote(String emotion) async {
    try {
      quote.value = "";
      quoteList.clear();
      final response = await Dio().get(
        'https://favqs.com/api/quotes/?filter=$emotion',
        options: Options(headers: {'Authorization': 'Token $_apiKey'}),
      );

      if (response.statusCode == 200) {
        isError.value = false;
        final List<dynamic> quotes = response.data['quotes'];
        if (quotes.isNotEmpty) {
          final randomQuote = quotes[Random().nextInt(quotes.length)];
          quote.value = randomQuote['body'];
          Quote newQuote = Quote(
              text: quote.value,
              author: randomQuote["author"],
              emotion: emotion,
              timestamp: DateTime.now().toString());
          quoteModel.value = newQuote;

          DatabaseHelper databaseHelper = DatabaseHelper();
          databaseHelper.database;
          databaseHelper.initDatabase();
          databaseHelper.insertEmotion(
              newQuote.emotion, DateTime.now().toString(), newQuote.text, newQuote.author);
          quoteList.add(newQuote);
          getImage(emotion);
          sendNotification(emotion);
        } else {
          print("No quotes available for this emotion.");
        }
      } else {
        print("Failed to fetch quote. Status code: ${response.statusCode}");
      }
    } catch (error) {
      isError.value = true;
      print("Error: $error");
    }
  }

  getImage(String emotion) async {
    imglink.value = "${emotion.toLowerCase()}.jpg";
  }

  Quote getQuote() {
    if (quoteList.isNotEmpty) {
      return quoteList.last;
    } else {
      return Quote(text: "", author: "", emotion: "", timestamp: "");
    }
  }

  Future<void> sendNotification(String emotion) async {
    return await NotificationService.showNotification(
      title: "Emotion Tracker",
      body: "How are you feeling now? If you still feel the same, you can get a new quote.",
      schedule: true,
      interval: 300, // 300 seconds, 5 minutes
      payload: {"emotion": emotion},
      actionButtons: [
        NotificationActionButton(
          key: "CHANGE_EMOTION_KEY",
          label: "Change Emotion",
        ),
        NotificationActionButton(
          key: "GET_NEW_QUOTE_KEY",
          label: "Get New Quote",
        ),
      ],
    );
  }
}
