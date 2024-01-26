import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:emotion_tracker/controllers/quote_display_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/quote_display_page.dart';

class NotificationService {
  QuoteDisplayPageController quoteDisplayPageController = Get.find<QuoteDisplayPageController>();

  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: "high_importance_channel",
          channelKey: "high_importance_channel",
          channelName: "Basic notifications",
          channelDescription: "Notification channel for basic tests",
          defaultColor: Colors.pink,
          ledColor: Colors.yellow,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "high_importance_channel_group",
          channelGroupName: "Group 1",
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  // use this method to detect when a new notification or schedule is created
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint("onDismissActionReceivedMethod");
  }

  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    QuoteDisplayPageController quoteDisplayPageController = Get.find<QuoteDisplayPageController>();

    String selectedEmotion = receivedAction.payload?["emotion"] ?? "";
    if (selectedEmotion.isNotEmpty) {
      if (receivedAction.buttonKeyPressed == "CHANGE_EMOTION_KEY") {
        Get.back();
      } else if (receivedAction.buttonKeyPressed == "GET_NEW_QUOTE_KEY") {
        quoteDisplayPageController.fetchQuote(selectedEmotion);
        Get.to(QuoteDisplayPage());
      }
    }
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  }) async {
    assert(!schedule || (schedule && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "high_importance_channel",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: schedule
          ? NotificationInterval(
              interval: interval,
              timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
