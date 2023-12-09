import 'package:flutter/material.dart';

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
    this.textColor,
    required this.label,
    required this.hintText,
  }) : super(key: key);

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  bool _obscureText = true;

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

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon:
            Icon(getPrefixIcon(), color: const Color.fromARGB(255, 80, 78, 78)),
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
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
      style: TextStyle(color: widget.textColor),
      maxLines: widget.messageField == true ? null : 1,
      textInputAction: widget.onEditingComplete != null
          ? TextInputAction.next
          : widget.messageField
              ? TextInputAction.newline
              : null,
    );
  }
}
