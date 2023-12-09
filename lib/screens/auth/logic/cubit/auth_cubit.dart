import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/logic/repository/auth_repository.dart';
// import 'package:auth/src/features/notification/logic/repository/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:shop_app/screens/auth/view/sign_up/components/resend_code_form.dart';

class AuthCubit extends Cubit<User?> {
  AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(null);

  Future<void> authenticate(
      String email, String password, BuildContext context) async {
    print(1);
    authRepository.deleteAccessToken();
    authRepository.deleteRefreshToken();
    authRepository.isValidLoginForm(email, password, context);
    print(2);
    return _loginWith(
        () => authRepository.authenticate(email, password, context));
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
    print(user);
    return user;
  }

  Future<void> logout() async {
    emit(null);

    await authRepository.logout();
    // await notificationRepository.deleteSubscription();
  }

  Future<void> updateProfile() async {
    emit(await this.authRepository.getProfile());
  }

  Future<void> verify(String code, String confirmToken) async {
    return await this.authRepository.verify(code, confirmToken);
  }

  Future<String> resendCode(String email) async {
    return await this.authRepository.resend(email);
  }
}
