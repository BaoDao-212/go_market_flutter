import 'package:shop_app/screens/auth/logic/interceptors/auth_token_interceptor.dart';
import 'package:shop_app/screens/auth/logic/models/token.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/screens/shared/logic/http/interceptors/error_dialog_interceptor.dart';

class AuthAPIProvider {
  Future<Tokens> authenticate(String email, String password) async {
    print(11);
    print(email);
    final response = await api.post(
      'http://192.168.43.230:8001/api/user/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    print(response);
    // print(13222);
    // try {
    //   // Thực hiện yêu cầu POST với dữ liệu đăng nhập
    //   final response = await dio.post(
    //     'http://192.168.43.230:8001/api/user/login',
    //     data: {
    //       'email': 'baodaoc1@gmail.com',
    //       'password': '123123',
    //     },
    //   );
    //   print(response);
    //   // Kiểm tra mã trạng thái của response
    //   if (response.statusCode == 200) {
    //     // Xử lý thành công
    //     print('Login successful! Token: ${response.data['token']}');
    //   } else {
    //     // Xử lý lỗi
    //     print('Login failed. ${response.data['error']}');
    //   }
    // } catch (error) {
    //   // Xử lý lỗi nếu có
    //   print('Error during login: $error');
    // }
    // print(123);
    // return Tokens(accessToken: '123');
    final tokens = Tokens.fromJson(response?.data);
    return tokens;
  }

  Future<Tokens> register(
    String username,
    String password,
    String email,
  ) async {
    final response = await api.post(
      '/auth/register',
      data: {
        'username': username,
        'password': password,
        'email': email,
      },
    );

    final tokens = Tokens.fromJson(response.data);

    return tokens;
  }

  Future<void> recover(String email) async {
    await api.post(
      '/recover',
      data: {
        'email': email,
      },
    );
  }

  Future<User?> getProfile() async {
    final response = await api.get(
      '/auth/me',
      options: Options(
        headers: {
          ErrorDialogInterceptor.skipHeader: true,
        },
      ),
    );

    return User.fromJson(response.data);
  }

  Future<Tokens> loginWithFacebook(String? accessToken) {
    return _socialLogin(
      provider: 'facebook',
      accessToken: accessToken,
    );
  }

  Future<Tokens> loginWithGoogle(String? accessToken) {
    return _socialLogin(
      provider: 'google',
      accessToken: accessToken,
    );
  }

  Future<Tokens> loginWithApple({
    required String? identityToken,
    required String authorizationCode,
    String? givenName,
    String? familyName,
    String? type,
  }) {
    return _socialLogin(
      provider: 'apple',
      accessToken: identityToken,
      authorizationCode: authorizationCode,
      type: type,
      name: '$givenName $familyName',
    );
  }

  Future<Tokens> _socialLogin({
    required String provider,
    required String? accessToken,
    String? authorizationCode,
    String? type,
    String? name,
  }) async {
    final response = await api.post(
      '/auth/$provider-login',
      data: {
        'name': name,
        'accessToken': accessToken,
        'authorizationCode': authorizationCode,
        'type': type,
      },
    );

    return Tokens.fromJson(response.data);
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
