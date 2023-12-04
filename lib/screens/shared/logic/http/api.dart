import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:shop_app/screens/shared/logic/http/interceptors/error_dialog_interceptor.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart';

Dio _createHttpClient() {
  final api = new Dio(
    new BaseOptions(
      baseUrl: environments.api,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    ),
  );

  api
    ..interceptors.add(new ErrorDialogInterceptor())
    ..interceptors.add(new AuthTokenInterceptor(api));

  return api;
}

final api = _createHttpClient();
