import 'package:flutter/material.dart';
import 'package:shop_app/components/send_code.dart';
import '../../../../../constants.dart';
import '../../../../../size_config.dart';
import '../components/verify_email.dart';

class VerifyEmailScreen extends StatelessWidget {
  static const String routeName = "/verify";
  final String confirmToken;

  VerifyEmailScreen({required this.confirmToken});
  static route(String confirmToken) => MaterialPageRoute(
        builder: (_) => VerifyEmailScreen(
            confirmToken: confirmToken), // Pass as a named argument
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify email"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text("Verify Account", style: headingStyle),
                  Text(
                    "Open your email to get the verification code",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  VerifyEmailForm(confirmToken: confirmToken),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  ResendCode(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
