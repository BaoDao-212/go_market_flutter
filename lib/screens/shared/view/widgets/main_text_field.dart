import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/shared/logic/http/api.dart';
import 'package:shop_app/size_config.dart';

class MainTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool passwordField;
  final bool emailField;
  final bool messageField;
  final bool usernameField;
  final bool readOnly;
  final Color? textColor;

  const MainTextField({
    Key? key,
    this.onChanged,
    this.controller,
    this.onEditingComplete,
    this.onSubmitted,
    this.passwordField = false,
    this.emailField = false,
    this.messageField = false,
    this.usernameField = false,
    this.readOnly = false,
    this.textColor,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool _obscureText = true;
  String error = '';

  IconData getPrefixIcon() {
    if (widget.passwordField) {
      return Icons.lock;
    } else if (widget.emailField) {
      return Icons.email;
    } else if (widget.usernameField) {
      return Icons.person;
    } else {
      // Default case
      return Icons.error;
    }
  }

  IconData getSuffixIcon() {
    if (widget.passwordField) {
      return _obscureText ? Icons.visibility : Icons.visibility_off;
    } else {
      // No suffix icon for non-password fields
      return Icons.error;
    }
  }

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
          readOnly: widget.readOnly,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            prefixIcon: Icon(
              getPrefixIcon(),
              color: const Color.fromARGB(255, 80, 78, 78),
            ),
            suffixIcon: widget.passwordField
                ? IconButton(
                    icon: Icon(
                      getSuffixIcon(),
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.all(16),
            hintStyle: TextStyle(color: widget.textColor),
          ),
          keyboardType: widget.emailField
              ? TextInputType.emailAddress
              : widget.messageField
                  ? TextInputType.multiline
                  : null,
          obscureText: widget.passwordField && _obscureText,
          autocorrect: !widget.usernameField && !widget.emailField,
          controller: widget.controller,
          onChanged: (value) {
            _validator(value);
          },
          onEditingComplete: widget.onEditingComplete,
          cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
          style: TextStyle(color: widget.textColor),
          maxLines: widget.messageField ? null : 1,
          textInputAction: widget.onEditingComplete != null
              ? TextInputAction.next
              : widget.messageField
                  ? TextInputAction.newline
                  : null,
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

  _validator(value) {
    if (widget.emailField) {
      if (value.isNotEmpty) {
        removeError();
      }
      if (value.isEmpty) {
        addError(errorText: 'Email is required');
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
          .hasMatch(value)) {
        addError(errorText: 'Please enter a valid email address');
      } else {
        removeError();
      }
    } else if (widget.usernameField) {
      if (value.isNotEmpty) {
        removeError();
      }
      if (value.isEmpty) {
        addError(errorText: 'Name is required');
      } else if (value.length < 3 || value.length > 30) {
        addError(errorText: 'Username must be between 3 and 30 characters');
      } else {
        removeError();
      }
    } else if (widget.passwordField) {
      if (value.isNotEmpty) {
        removeError();
      }
      if (value.isEmpty) {
        addError(errorText: 'Password is required');
      } else if (value.length < 6) {
        addError(errorText: 'Passwords must be at least 6 characters');
      } else {
        removeError();
      }
    }
  }
}
