import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/size_config.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  ConfirmPasswordTextField({
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  _ConfirmPasswordTextFieldState createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _obscureText = true;
  String error = '';

  void addError({required String errorText}) {
    setState(() {
      error = errorText;
    });
  }

  void removeError() {
    setState(() {
      error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: Icon(
              Icons.lock,
              color: const Color.fromARGB(255, 80, 78, 78),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Color.fromARGB(255, 95, 95, 95),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.all(16),
          ),
          obscureText: _obscureText,
          autocorrect: false,
          controller: widget.confirmPasswordController,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError();
            }
            if (value != widget.passwordController.text) {
              addError(errorText: 'Passwords do not match');
            } else {
              removeError();
            }
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(errorText: 'Confirm Password is required');
            } else if (value != widget.passwordController.text) {
              addError(errorText: 'Passwords do not match');
            }
            return null;
          },
          cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
        ),
        if (error.isNotEmpty)
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/Error.svg",
                height: getProportionateScreenWidth(14),
                width: getProportionateScreenWidth(14),
              ),
              SizedBox(
                width: getProportionateScreenWidth(10),
              ),
              Text(error),
            ],
          )
      ],
    );
  }
}
