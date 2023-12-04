import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/view/login.dart';
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
import 'package:shop_app/screens/auth/view/sign_up/sign_up_screen.dart';

// // We use name route
// // All our routes will be available here
// final Map<String, WidgetBuilder> routes = {
//   SplashScreen.routeName: (context) => SplashScreen(),
//   LoginScreen.routeName: (context) => LoginScreen(),
//   SignInScreen.routeName: (context) => SignInScreen(),
//   ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
//   LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
//   SignUpScreen.routeName: (context) => SignUpScreen(),
//   CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
//   OtpScreen.routeName: (context) => OtpScreen(),
//   HomeScreen.routeName: (context) => HomeScreen(),
//   DetailsScreen.routeName: (context) => DetailsScreen(),
//   CartScreen.routeName: (context) => CartScreen(),
//   ProfileScreen.routeName: (context) => ProfileScreen(),
// };

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      default:
        return LoginScreen.route();
    }
  }
}
