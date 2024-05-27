import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:chat_app_new/view/chat/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';

class NotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("User authorization");
      }
    } else {
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  //! get devices token
  Future<String> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    final data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // Check if the 'token' field is present and not null
    if (data['token'] == null) {
      // Update the 'token' field with the new token
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'token': token});
    }
    return token!;
  }

//! send notification
  Future<void> sendNotification(String token, String username, String message,
      String id, String imageUrl) async {
    final data = {
      "to": token,
      "priority": 'high',
      "notification": {
        "title": username,
        "body": message,
        "image":
            "https://firebasestorage.googleapis.com/v0/b/fir-b1e27.appspot.com/o/pngtree-3d-bubble-chat-icon-png-image_2988387-removebg-preview.png?alt=media&token=43b9568d-0215-4982-9fc4-686070ebc215"
      },
      "data": {
        "type": "chats",
        "id": id,
        "username": username,
        "imageUrl": imageUrl
      }
    };
    final response = await post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        'Authorization':
            "key=AAAAu1OOfrU:APA91bGMeERdHxCvMW-HNIAf5Aiv78NOCx4QgGAP_ahccjfGLwWMN84-9372bBtpDe2BG9CF01mxa0nqtqEKD63Bt1PN7tC-NQJOkvudf4Ov7raUDDATBCjmIr8LHCHCzh-H2ALfylZO"
      },
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('done');
      }
    }
  }

  // ! initialize the android icon
  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    final intilizations = InitializationSettings(android: android);
    await localNotificationsPlugin.initialize(intilizations,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  // ! listen the message when the app in foreground
  void firebaseinit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      }
    });
  }

  // ! show the notification
  void showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),
      "High Importance Notifications",
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(
        1,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    });
  }

  // ! setup for when app is teminated or run in background
  Future<void> setUpInteractMessage(BuildContext context) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      if (context.mounted) {
        handleMessage(context, message);
      }
    }
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == "chats") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                    userId: message.data['id'],
                    imageUrl: message.data['imageUrl'],
                    userName: message.data['username'],
                  )));
    }
  }
}
