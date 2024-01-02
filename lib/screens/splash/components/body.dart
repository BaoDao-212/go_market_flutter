import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/app_export.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/logic/models/user.dart';
import 'package:shop_app/screens/auth/logic/repository/auth_repository.dart';
import 'package:shop_app/screens/auth/view/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Go Market", "image": "assets/images/splash_1.png"},
    {
      "text":
          "We help people effortlessly manage your shopping list \n and smartly schedule your cooking plans",
      "image": "assets/images/splash_2.png"
    },
    {
      "text":
          "We show the easy way to manage and plan. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  dynamic accessToken = '';
  @override
  void initState() {
    super.initState();
    initAuth();
  }

  void initAuth() async {
    AuthRepository authRepository = AuthRepository();
    accessToken = await authRepository.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => AnimatedContainer(
                          duration: kAnimationDuration,
                          margin: EdgeInsets.only(right: 5),
                          height: 6,
                          width: currentPage == index ? 20 : 6,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? kPrimaryColor
                                : Color(0xFFD8D8D8),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    Spacer(flex: 1),
                    BlocBuilder<AuthCubit, User?>(
                      builder: (context, user) {
                        print(accessToken);
                        if (accessToken == null) {
                          return DefaultButton(
                            text: "Continue",
                            press: () {
                              Navigator.pushNamed(
                                  context, SignInScreen.routeName);
                            },
                          );
                        } else {
                          return DefaultButton(
                            text: "Continue",
                            press: () async {
                              final bloc = context.read<AuthCubit>();
                              final user = await bloc.updateProfile();
                              print(user);
                              Navigator.pushNamed(
                                  context, HomeScreen.routeName);
                            },
                          );
                        }
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
