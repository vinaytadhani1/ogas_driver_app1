// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:ogas_driver_app/auth/app_const.dart';

class AppNotificationHandler {
  static BuildContext? context;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: "description",
    importance: Importance.high,
  );
  static Future<void> firebaseNotificationSetup() async {
    /// FIREBASE_INITIALLIZE...
    await Firebase.initializeApp();

    /// LOCAL_NOTIFICATION...
    FirebaseMessaging.onBackgroundMessage(
      firebaseMessagingBackgroundHandler,
    );

    await FirebaseMessaging.instance.getInitialMessage();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(channel);
    var androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitializationSettings = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (pay) {
        Navigator.pushNamed(context!, '/home');
      },
    );

    /// Update the iOS foreground notification presentation options to allow
    // heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// GET_FCM_TOKEN...
    await getFcmToken(context);
  }

  /// GET_FCM_TOKEN...
  static Future<String?> getFcmToken(BuildContext? context) async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    try {
      String? token = await firebaseMessaging.getToken().catchError((e) {
        log("=========fcm- Error ....:$e");
      });

      log("=========fcm-token===$token");

      return token;
    } catch (e) {
      log("=========fcm- Error :$e");
    }
    return null;
  }

  /// CALL_WHEN_APP_IN_FOREGROUND...
  static void showMsgHandler(BuildContext? context) {
    print('showMsgHandler...');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print(
          'Notification Call :${notification!.apple}${notification.body}${notification.title}');
      showMsg(notification, context);
    }).onError((e) {
      print('Error Notification : ....$e');
    });
  }

  /// HANDLE_NOTIFICATION_WHEN_APP_IN_FOREGROUND...
  static void getInitialMsg(BuildContext? context) {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message!.data.isEmpty) {
        Navigator.pushNamed(context!, '/home');
      } else {
        final mapData = message.data;
        // Navigator.of(context!).push(MaterialPageRoute(builder: (context) {
        //   return ChattingScreen(
        //     userImg: mapData['userImg'],
        //     receiverId: mapData['receiveId'],
        //     userName: mapData['userName'],
        //     token: mapData['token'],
        //   );
        // }));
      }
    });
  }

  /// SHOW_NOTIFICATION_MSG...
  static void showMsg(RemoteNotification notification, BuildContext? context) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            channelDescription: 'description',
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
          ),
        ));
  }

  /// BACKGROUND_NOTIFICATION_HANDLER...
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    // RemoteNotification? notification = message.notification;
  }

  /// CALL_WHEN_CLICK_ON_NOTIFICATION...

  static void onMsgOpen(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      print('A new onMessageOpenedApp event was published!');

      print('listen->${message?.data}');
      print('listen->${message?.category}');
      print('listen->${message?.collapseKey}');
      print('listen->${message?.contentAvailable}');
      print('listen->${message?.from}');
      print('listen->${message?.messageId}');
      print('listen->${message?.messageType}');
      print('listen->${message?.mutableContent}');
      print('listen->${message?.notification}');
      print('listen->${message?.senderId}');
      print('listen->${message?.sentTime}');
      print('listen->${message?.threadId}');
      print('listen->${message?.ttl}');
      print('-----------------------------------');

      if (message!.data.isEmpty) {
        print('+++++++++++++++++++++++++++++++++++');

        Navigator.pushNamed(context, '/home');
      } else {
        print('******************************');
        final mapData = message.data;
        // Get.to(ChattingScreen(
        //   userImg: mapData['userImg'],
        //   receiverId: mapData['receiveId'],
        //   userName: mapData['userName'],
        //   token: mapData['token'],
        // ));
      }
    });
  }

  /// SEND_NOTIFICATION_FROM_ONE_DEVICE_TO_ANOTHER_DEVICE...
  static Future<void> sendMessage(
      {String? receiverFcmToken,
      String? msg,
      BuildContext? context,
      Map<String, dynamic>? dataMap}) async {
    var serverKey = AppConst().serverKey;

    
    if (receiverFcmToken == '') {
      return;
    }
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': msg, 'title': 'userName'},
            'priority': 'high',
            'data': dataMap ??
                <String, dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'id': '1',
                  'status': 'done',
                },
            'to': receiverFcmToken,
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");
      log("RESPONSE BODY ${response.body}");
    } catch (e) {
      print("error push notification");
    }
  }
}
