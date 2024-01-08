import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/firebase.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/logic/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';

class AuthCubit extends Cubit<User?> {
  AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(null);

  Future<void> authenticate(
      String email, String password, BuildContext context) async {
    print(email);
    return _loginWith(
        () => authRepository.authenticate(email, password, context));
  }

  Future<void> saveToken() async {
    final fcmToken = await FirebaseService.getFCMToken();
    authRepository.saveToken(fcmToken as String);
  }

  Future<dynamic> register(String name, String email, String password) async {
    return await authRepository.register(
      name,
      email,
      password,
    );
  }

  Future<void> _loginWith(Function method) async {
    final (_, user) = await method();
    emit(user);
  }

  Future<void> logout() async {
    emit(null);

    await authRepository.logout();
    // await notificationRepository.deleteSubscription();
  }

  Future<dynamic> updateProfile() async {
    final user = await this.authRepository.getProfile();
    print(user);
    emit(user);
    return user;
  }

  Future<void> verify(String code, String confirmToken) async {
    return await this.authRepository.verify(code, confirmToken);
  }

  Future<String> resendCode(String email) async {
    return await this.authRepository.resend(email);
  }
}
