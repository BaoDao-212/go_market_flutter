import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/view/sign_up/resend_code.dart/resend_code.dart';

import '../constants.dart';
import '../size_config.dart';

class ResendCode extends StatelessWidget {
  const ResendCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, ResendCodeScreen.routeName),
          child: Text(
            "Resend code",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
