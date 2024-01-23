import 'dart:math';

import 'package:dio/dio.dart';
import 'package:emotion_tracker/models/quote.dart';
import 'package:emotion_tracker/services/database_helper.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class QuoteDisplayPageController extends GetxController {
  final quote = "".obs;
  final imglink = "".obs;
  final String _apiKey =
      '00fa553d76e5afea18e8d00a83c45619'; // Oluşturduğunuz API anahtarını buraya ekleyin

  List<Quote> quoteList = <Quote>[].obs;

  Rx<Quote> quoteModel = Quote(emotion: "", timestamp: "", text: "", author: "").obs;

  Future<void> fetchQuote(String emotion) async {
    try {
      quote.value = "";
      final response = await Dio().get(
        'https://favqs.com/api/quotes/?filter=$emotion',
        options: Options(headers: {'Authorization': 'Token $_apiKey'}),
      );

      if (response.statusCode == 200) {
        print("1");
        // Başarılı durumu
        final List<dynamic> quotes = response.data['quotes'];
        if (quotes.isNotEmpty) {
          print("2");
          final randomQuote = quotes[Random().nextInt(quotes.length)];
          print(randomQuote);
          print(randomQuote["author"]);
          quote.value = randomQuote['body'];
          Quote newQuote = Quote(
              text: quote.value,
              author: randomQuote["author"],
              emotion: emotion,
              timestamp: DateTime.now().toString());

          DatabaseHelper databaseHelper = DatabaseHelper();
          databaseHelper.database;
          databaseHelper.initDatabase();
          databaseHelper.insertEmotion(
              newQuote.emotion, DateTime.now().toString(), newQuote.text, newQuote.author);

          print("ccccccc ${quoteModel.value.author}");
          quoteList.add(newQuote);
          getImage(emotion);
        } else {
          print("3");
          print("No quotes available for this emotion.");
        }
      } else {
        print("4");

        // Başarısız durumu
        print("Failed to fetch quote. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("5");

      // Hata durumu
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
      // Eğer liste boşsa, null veya başka bir değer dönebilirsiniz.
      return Quote(text: "", author: "", emotion: "", timestamp: "");
    }
  }
}
