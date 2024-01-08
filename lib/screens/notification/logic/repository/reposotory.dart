import 'package:shop_app/screens/notification/logic/provider/provider.dart';

class NotificationRepository {
  final NotificationAPIProvider _apiProvider = NotificationAPIProvider();

  NotificationRepository();

  Future<dynamic> getNotificationList() async {
    final apiResponse = await _apiProvider.getNotificationList();
    return apiResponse;
  }

  Future<dynamic> createNotification(
      int id, String body, String title, String date) async {
    await _apiProvider.createNotification(id, body, title, date);
    final apiResponse = await _apiProvider.getNotificationList();
    return apiResponse;
  }
}
