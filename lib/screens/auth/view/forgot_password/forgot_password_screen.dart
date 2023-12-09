import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot_password";
  static route() => MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Body(),
    );
  }
}
