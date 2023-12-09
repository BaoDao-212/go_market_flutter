import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static const String routeName = "/otp";
  static route() => MaterialPageRoute(builder: (_) => OtpScreen());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(),
    );
  }
}
