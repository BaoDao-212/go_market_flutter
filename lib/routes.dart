import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/view/sign_up/verify_email/verify_email.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/auth/view/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/auth/view/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/auth/view/login_success/login_success_screen.dart';
import 'package:shop_app/screens/auth/view/sign_up/register/sign_up_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case DetailsScreen.routeName:
        return DetailsScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case LoginSuccessScreen.routeName:
        return LoginSuccessScreen.route();
      case ForgotPasswordScreen.routeName:
        return ForgotPasswordScreen.route();
      case OtpScreen.routeName:
        return OtpScreen.route();
      case CompleteProfileScreen.routeName:
        return CompleteProfileScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      default:
        return SignInScreen.route();
    }
  }
}
