import 'package:dio/dio.dart';
import 'package:shop_app/screens/app.dart';
import 'package:shop_app/screens/shared/view/widgets/dialog/notification_dialog.dart';

class ErrorDialogInterceptor extends Interceptor {
  static const skipHeader = 'skipDialog';

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    final context = applicationKey.currentContext;

    if (context == null) {
      return;
    }
    NotificationHelper.show(
      err.response?.data['resultMessage']['en'],
      "ERROR",
    );

    return super.onError(err, handler);
  }
}
