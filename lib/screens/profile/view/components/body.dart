import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/profile/view/my_account/my_account.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                MyProfileScreen.routeName,
                (route) => false,
              );
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () => _logout(context),
          ),
        ],
      ),
    );
  }

  _logout(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    bloc.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
      SplashScreen.routeName,
      (route) => false,
    );
  }
}
