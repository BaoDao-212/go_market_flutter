import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/view/sign_up/register/sign_up_screen.dart';
import 'package:shop_app/screens/auth/view/sign_up/verify_email/verify_email.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import '../../../../../size_config.dart';
import 'package:shop_app/screens/auth/logic/accuracy/validate_signup.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpForm createState() => _SignUpForm();
}

class _SignUpForm extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _loading = false;
  final List<String?> errors = [];

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
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
            text: "Register",
            onPressed: () => _signUp(context),
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
          label: 'Name',
          hintText: 'Enter your name',
          controller: _nameController,
          usernameField: true,
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        MainTextField(
          label: 'Email',
          hintText: 'Enter your email',
          emailField: true,
          controller: _emailController,
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        MainTextField(
          label: 'Password',
          hintText: 'Enter your password',
          controller: _passwordController,
          passwordField: true,
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        MainTextField(
          label: 'Password',
          hintText: 'Confirm your password',
          controller: _confirmPasswordController,
          passwordField: true,
          onSubmitted: (_) {
            node.unfocus();
            _signUp(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _signUp(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    print(_emailController.text);
    final vali = ValidateSignUp();
    vali.isValidSignUpForm(_nameController.text, _emailController.text,
        _passwordController.text, _confirmPasswordController.text);
    _signUpWith(
      context,
      () => bloc.register(_nameController.text, _emailController.text,
          _passwordController.text),
    );
  }

  _signUpWith(BuildContext context, Future<dynamic> Function() method) async {
    if (_loading) {
      return;
    }
    // setState(() {
    //   _loading = true;
    // });

    try {
      final token = await method();
      print(token);
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
      _confirmPasswordController.text = '';
      _passwordController.text = '';
      _emailController.text = '';
      _nameController.text = '';

      setState(() {
        _loading = false;
      });
    }
  }
}
