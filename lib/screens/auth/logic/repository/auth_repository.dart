import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shop_app/firebase.dart';
import 'package:shop_app/screens/auth/logic/models/token.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/logic/provider/auth_api_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as store;
import 'package:email_validator/email_validator.dart';

class AuthRepository {
  final _provider = AuthAPIProvider();
  late final _storage = new store.FlutterSecureStorage();

  String getDeviceType() {
    String type = 'web';

    if (Platform.isIOS) {
      type = 'ios';
    }

    if (Platform.isAndroid) {
      type = 'android';
    }

    return type;
  }

  Future<void> logout() async {
    await deleteAccessToken();
    await deleteRefreshToken();
  }

  Future<User?> getProfile() async {
    if (await getAccessToken() == null && await getRefreshToken() == null) {
      return null;
    }

    try {
      final profile = await _provider.getProfile();
      print(profile);
      return profile;
    } catch (e) {
      return null;
    }
  }

  Future<(Future<dynamic>, dynamic)> authenticate(
      String email, String password, BuildContext context) async {
    final (tokens, user) = await _provider.authenticate(email, password);

    return (setTokens(tokens), user);
  }

  Future<String> register(String name, String email, String password) async {
    return await _provider.register(name, email, password);
  }

  Future<void> verify(String code, String confirmToken) async {
    final tokens = await _provider.verify(code, confirmToken);
    return setTokens(tokens);
  }

  Future<String> resend(String email) async {
    final tokens = await _provider.resend(email);
    return tokens;
  }

  Future<void> loginWithRefreshToken() async {
    return setTokens(
      await _provider.loginWithRefreshToken(await getRefreshToken()),
    );
  }

  Future<void> logoutFromAllDevices() async {
    return setTokens(await _provider.logoutFromAllDevices());
  }

  Future<void> saveToken(String token) {
    return _provider.saveNotificationToken(token);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: 'accessToken');
  }

  Future<void> setAccessToken(String token) {
    return _storage.write(key: 'accessToken', value: token);
  }

  Future<void> deleteAccessToken() {
    return _storage.delete(key: 'accessToken');
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: 'refreshToken');
  }

  Future<void> setRefreshToken(String token) {
    return _storage.write(key: 'refreshToken', value: token);
  }

  Future<void> deleteRefreshToken() {
    return _storage.delete(key: 'refreshToken');
  }

  Future<void> setTokens(Tokens tokens) async {
    await setAccessToken(tokens.accessToken);
    await setRefreshToken(tokens.refreshToken);
  }

  Future<void> isValidLoginForm(
      String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Please enter both email and password.',
      );
    }
    if (!EmailValidator.validate(email)) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Email is not valid.',
      );
    }
    if (password.length < 6) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: 'Password is not valid. It should be at least 6 characters.',
      );
    }
    return;
  }
}
