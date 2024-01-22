import 'dart:math';

import 'package:dio/dio.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class QuoteDisplayPageController extends GetxController {
  final quote = "".obs;
  final String _apiKey =
      '00fa553d76e5afea18e8d00a83c45619'; // Oluşturduğunuz API anahtarını buraya ekleyin

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
        print(quotes);
        if (quotes.isNotEmpty) {
          print("2");

          final randomQuote = quotes[Random().nextInt(quotes.length)];
          print(randomQuote['body']);
          quote.value = randomQuote['body'];
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
}
