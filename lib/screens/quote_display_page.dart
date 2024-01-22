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
      () => Center(
        child: quoteDisplayPageController.quote.value.isEmpty
            ? const CircularProgressIndicator()
            : Text(
                quoteDisplayPageController.quote.value,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
      ),
    ));
  }
}
