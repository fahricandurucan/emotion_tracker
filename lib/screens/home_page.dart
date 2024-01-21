import 'package:emotion_tracker/const/const.dart';
import 'package:emotion_tracker/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              historyButton(),
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
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 142, 230, 145), // Arka plan rengi
        ),
        child: const Text(
          "Show History",
          style: TextStyle(color: Colors.white),
        ));
  }
}

class EmotionButton extends StatelessWidget {
  final String emotion;

  const EmotionButton({Key? key, required this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // İstediğiniz boyutu ayarlayabilirsiniz
      height: 150, // İstediğiniz boyutu ayarlayabilirsiniz
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        // border: Border.all(
        //   color: Colors.black, // Kenar rengini ayarlayabilirsiniz
        // ),
        boxShadow: [
          BoxShadow(
            color: Const.positiveEmotion.contains(emotion)
                ? const Color.fromARGB(255, 222, 244, 255)
                : const Color.fromARGB(255, 255, 223, 220),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1), // gölge konumu
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Burada duygu seçildiğinde yapılacak işlemleri ekleyebilirsin.
          // Örneğin, veritabanına kaydetme ve alıntıyı getirme işlemleri.
          // Bu noktada navigator kullanarak bir sonraki sayfaya geçebilirsin.
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Const.positiveEmotion.contains(emotion)
              ? const Color.fromARGB(255, 175, 230, 255)
              : const Color.fromARGB(
                  255, 255, 151, 144), // Olumlu ve olumsuz duyguları renklendirmek için kontrol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          emotion,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
