import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/auth/view/login_success/login_success_screen.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/shared/view/widgets/next_button.dart';
import '../../../../../components/default_button.dart';
import '../../../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  final _passwordController = TextEditingController();
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
          DefaultButton(
            text: "Login",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen

                KeyboardUtil.hideKeyboard(context);
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
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
          emailField: true,
          onChanged: (value) => setState(() {
            _email = value;
          }),
          onEditingComplete: () => node.nextFocus(),
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        MainTextField(
          label: 'Password',
          hintText: 'Enter your password',
          controller: _passwordController,
          passwordField: true,
          onSubmitted: (_) {
            node.unfocus();
            _login(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            NextButton(
              onPressed: () => _login(context),
              loading: _loading,
            )
          ],
        ),
      ],
    );
  }

  _login(BuildContext context) {
    print(_email);
    final bloc = context.read<AuthCubit>();
    _loginWith(
      context,
      () => bloc.authenticate(
        _email,
        _passwordController.text,
      ),
    );
  }

  _loginWith(BuildContext context, Future<void> Function() method) async {
    if (_loading) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await method();
      print(123);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //   HomeScreen.routeName,
      //   (route) => false,
      // );
    } finally {
      setState(() {
        _loading = false;
      });

      _passwordController.text = '';
    }
  }
}
