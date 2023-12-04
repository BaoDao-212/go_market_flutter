import 'package:flutter/material.dart';

import 'components/body.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = "/sign_in";
  static route() => MaterialPageRoute(builder: (_) => SignInScreen());
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(),
    );
  }
}
