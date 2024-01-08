import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/home/view/home_screen.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import '../../../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
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
          SizedBox(height: getProportionateScreenHeight(20)),
          IconTextButton(
            text: "Login",
            onPressed: () => _login(context),
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
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _login(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    _loginWith(
      context,
      () => bloc.authenticate(
          _emailController.text, _passwordController.text, context),
    );
  }

  _loginWith(BuildContext context, Future<void> Function() method) async {
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
      _passwordController.text = '';
    });
    try {
      await method();
      context.read<AuthCubit>().saveToken();
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    } finally {
      setState(() {
        _loading = false;
      });
      _passwordController.text = '';
    }
  }
}
