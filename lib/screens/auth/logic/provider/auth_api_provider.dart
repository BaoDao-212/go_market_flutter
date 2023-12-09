import 'package:shop_app/screens/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:shop_app/screens/auth/logic/models/token.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/logic/http/interceptors/error_dialog_interceptor.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shop_app/screens/app.dart';

class AuthAPIProvider {
  _notification(String notification, String type) {
    final context = applicationKey.currentContext;
    if (context == null) {
      return;
    }
    QuickAlert.show(
        context: context,
        type: type == 'ERROR' ? QuickAlertType.error : QuickAlertType.success,
        title: "Oops...",
        text: notification);
  }

  final dio = Dio();
  static final String path = 'http://192.168.43.230:8001/api';
  Future<(Tokens, User)> authenticate(String email, String password) async {
    var response;
    final dio = Dio();
    try {
      response = await dio.post(
        "${path}/user/login",
        data: {
          'email': email,
          'password': password,
        },
      );
      final tokens = Tokens.fromJson(response.data);
      final user = User.fromJson(response.data);
      return (tokens, user);
    } on DioError catch (e) {
      print(e.response?.data);
      _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<String> register(
    String name,
    String email,
    String password,
  ) async {
    var response;
    try {
      print(name);
      response = await dio.post(
        "${path}/user",
        data: {
          'email': email,
          'password': password,
          'name': name,
          'language': 'en',
          'timezone': '7',
          'deviceId': '1231123',
        },
      );
      print(response.data['confirmToken']);
      return response.data['confirmToken'];
    } on DioError catch (e) {
      print(e.response?.data);
      _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<void> recover(String email) async {
    await api.post(
      '/recover',
      data: {
        'email': email,
      },
    );
  }

  Future<Tokens> verify(String code, String confirmToken) async {
    try {
      final response = await dio.post(
        "${path}/user/verify-email",
        data: {
          'code': code,
          'token': confirmToken,
        },
      );
      final tokens = Tokens.fromJson(response.data);
      return tokens;
    } on DioError catch (e) {
      print(e.response?.data);
      _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<String> resend(String email) async {
    try {
      final response = await dio.post(
        "${path}/user/send-verification-code",
        data: {
          'email': email,
        },
      );
      return response.data['confirmToken'];
    } on DioError catch (e) {
      print(e.response?.data);
      _notification(e.response?.data['resultMessage']['en'], "ERROR");
      rethrow;
    }
  }

  Future<User?> getProfile() async {
    final response = await api.get(
      '/user',
      options: Options(
        headers: {
          ErrorDialogInterceptor.skipHeader: true,
        },
      ),
    );

    return User.fromJson(response.data);
  }

  Future<Tokens> loginWithRefreshToken(String? refreshToken) async {
    final response = await api.post(
      '/auth/refresh-token',
      data: {'refreshToken': refreshToken},
      options: Options(headers: {AuthTokenInterceptor.skipHeader: true}),
    );

    return Tokens.fromJson(response.data);
  }

  Future<Tokens> logoutFromAllDevices() async {
    final response = await api.delete('/auth/logout-from-all-devices');

    return Tokens.fromJson(response.data);
  }
}
