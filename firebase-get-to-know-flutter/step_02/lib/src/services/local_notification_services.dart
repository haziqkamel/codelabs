import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  ///Initialize
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize Flutter Local Notifications take context for navigating
  static void initialize(BuildContext context) {
    ///Initialization Settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (route) {
      if (route != null) {
        Navigator.of(context).pushNamed(route);
      }
    });
  }

  ///Use when app is in foreground, set the notification Important.MAX nad Priority.HIGH
  static void display(RemoteMessage message) async {
    try {
      ///ID
      final id = DateTime.now().microsecondsSinceEpoch.remainder(100000);

      ///NotificationDetails for Android settings
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Channel',
          channelDescription: 'This is a test for high importance channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['route'],
      );
    } catch (error) {
      print(error);
    }
  }
}
