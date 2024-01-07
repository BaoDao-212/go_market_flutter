import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isBold;
  final bool isItalic;
  final double fontSize;
  final bool underline;

  CustomTextField({
    required this.controller,
    this.hintText = '',
    this.isBold = false,
    this.isItalic = false,
    this.fontSize = 16.0,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle,
      ),
      style: textStyle,
    );
  }
}
