import 'package:shop_app/screens/notification/logic/local_db/index.dart';
import 'package:shop_app/screens/notification/logic/models/member.dart';

class NotificationAPIProvider {
  Future<List<Notification>> getNotificationList() async {
    final a = await DatabaseNotification.getNotifications();
    return a
        .sublist(
          a.length - 10,
          a.length,
        )
        .toList()
        .reversed
        .toList();
  }

  Future<void> createNotification(
      int id, String body, String title, String date) async {
    await DatabaseNotification.insertNotification(
        Notification(id: id, title: title, date: date, body: body));
  }
}
