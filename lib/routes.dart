import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/view/sign_up/resend_code.dart/resend_code.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/food/view/screen/foods_screen.dart';
import 'package:shop_app/screens/fridge/view/screen/fridge_screen.dart';
import 'package:shop_app/screens/group/view/screen/create_group_screen.dart';
import 'package:shop_app/screens/group/view/screen/group.screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/profile/view/components/profile_screen.dart';
import 'package:shop_app/screens/profile/view/my_account/my_account.dart';
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
      case ResendCodeScreen.routeName:
        return ResendCodeScreen.route();
      case SignUpScreen.routeName:
        return SignUpScreen.route();
      case CreateGroupPage.routeName:
        return CreateGroupPage.route();
      case GroupScreen.routeName:
        return GroupScreen.route();
      case FoodScreen.routeName:
        return FoodScreen.route();
      case FridgeScreen.routeName:
        return FridgeScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case DetailsScreen.routeName:
        return DetailsScreen.route();
      case MyProfileScreen.routeName:
        return MyProfileScreen.route();
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
