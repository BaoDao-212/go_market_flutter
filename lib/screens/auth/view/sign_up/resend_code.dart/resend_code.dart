import 'package:flutter/material.dart';
import '../../../../../constants.dart';
import '../../../../../size_config.dart';
import '../components/resend_code_form.dart';
import 'package:shop_app/components/send_code.dart';

class ResendCodeScreen extends StatelessWidget {
  static const String routeName = "/send-verification-code";

  static route() => MaterialPageRoute(builder: (_) => ResendCodeScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resend code"),
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
                  Text("Resend code", style: headingStyle),
                  Text(
                    "Please enter the email you registered with",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  ResendEmailForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
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
