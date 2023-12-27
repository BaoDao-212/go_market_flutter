import 'package:shop_app/screens/app.dart';
import 'package:quickalert/quickalert.dart';

class NotificationHelper {
  static void show(String notification, String type) {
    final context = applicationKey.currentContext;
    if (context == null) {
      return;
    }

    QuickAlert.show(
      context: context,
      type: type == 'ERROR' ? QuickAlertType.error : QuickAlertType.success,
      title: type == 'ERROR' ? "Error" : "Success",
      text: notification,
    );
  }
}
