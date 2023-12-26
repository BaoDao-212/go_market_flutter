import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/auth/logic/cubit/auth_cubit.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/shared/view/widgets/main_text_field.dart';
import 'package:shop_app/screens/shared/view/widgets/icon_text_button.dart';
import '../../../../../size_config.dart';

class VerifyEmailForm extends StatefulWidget {
  final String confirmToken;

  VerifyEmailForm({required this.confirmToken});

  @override
  _VerifyEmailForm createState() => _VerifyEmailForm();
}

class _VerifyEmailForm extends State<VerifyEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    super.dispose();

    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _form(node, context),
          SizedBox(height: getProportionateScreenHeight(20)),
          IconTextButton(
            text: "Verify Account",
            onPressed: () => _verify(context),
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
          label: 'Verification code',
          hintText: 'Enter your verification code',
          controller: _codeController,
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

  _verify(BuildContext context) {
    final bloc = context.read<AuthCubit>();
    _verifyWith(
      context,
      () => bloc.verify(_codeController.text, widget.confirmToken),
    );
  }

  _verifyWith(BuildContext context, Future<void> Function() method) async {
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
      _codeController.text = '';
    });
    try {
      await method();
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.routeName,
        (route) => false,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
