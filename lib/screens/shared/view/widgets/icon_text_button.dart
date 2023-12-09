import 'package:flutter/material.dart';

import './../../../../size_config.dart';
import './../../../../constants.dart';

class IconTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool? loading;
  const IconTextButton({Key? key, this.onPressed, this.loading, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: Colors.white,
            backgroundColor: kPrimaryColor,
          ),
          onPressed: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(),
              Text(
                text!,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
              IconButton(
                color: Colors.white,
                onPressed: onPressed,
                icon: loading == true
                    ? CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1.5,
                      )
                    : Icon(Icons.arrow_forward),
              ),
            ],
          )),
    );
  }
}
