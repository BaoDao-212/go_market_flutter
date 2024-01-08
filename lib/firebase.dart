import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/screens/notification/logic/local_db/index.dart';
import 'package:shop_app/screens/notification/logic/models/member.dart';

class FirebaseService {
  static Future<void> initializeFirebase(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static void insert(FlutterLocalNotificationsPlugin fln) async {
    String formattedDate =
        DateFormat('MM/dd/yyyy HH:mm').format(DateTime.now());
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await DatabaseNotification.insertNotification(Notification(
          id: 1,
          title: message.data['title'],
          date: formattedDate,
          body: message.data['body']));
      showNotification(
          title: message.data['title'], body: message.data['body'], fln: fln);
    });
  }

  static Future<void> showNotification(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    print(22);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    print(22);
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    // print(22);
    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   message.notification!.title,
    //   message.notification!.body,
    //   platformChannelSpecifics,
    // );
    var not = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, not);
  }
}
