import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/view/sign_up/verify_email/verify_email.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import '../../../../../size_config.dart';

class ResendEmailForm extends StatefulWidget {

  @override
  _ResendEmailForm createState() => _ResendEmailForm();
}

class _ResendEmailForm extends State<ResendEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;
  final List<String?> errors = [];

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _form(node, context),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          IconTextButton(
            text: "Resend",
            onPressed: () => _resend(context),
            loading: _loading,
          ),
        ],
      ),
    );
  }

  Widget _form(FocusScopeNode node, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTextField(
          label: 'Email',
          hintText: 'Enter your email',
          controller: _emailController,
          usernameField: true,
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _resend(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    _resendWith(
      context,
      () => bloc.resendCode(_emailController.text),
    );
  }

  _resendWith(BuildContext context, Future<String> Function() method) async {
    if (_loading) {
      return;
    }
    setState(() {
      _loading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      _emailController.text = '';
    });
    try {
      final token = await method();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyEmailScreen(confirmToken: token),
          settings: RouteSettings(
            arguments: 'confirmToken',
          ),
        ),
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
