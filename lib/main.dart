import 'package:emotion_tracker/notification/notification_service2.dart';
import 'package:emotion_tracker/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService2.initializeNotification();
  // tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

  // NotificationService().initNotification();
  // tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
