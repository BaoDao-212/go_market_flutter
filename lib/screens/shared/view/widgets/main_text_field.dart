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

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        suffixIcon: widget.passwordField
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
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
        contentPadding: EdgeInsets.all(21),
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
