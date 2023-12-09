import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static const String routeName = "/complete_profile";
  static route() => MaterialPageRoute(builder: (_) => CompleteProfileScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
