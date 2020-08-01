import 'package:flutter/material.dart';

import '../constant.dart';
import 'button_loading_indicator.dart';

enum AppButton {
  PLAIN,
  APPLE,
  GOOGLE,
  OTP,
}

class LoadingIndicator {
  final bool isLoading;
  final AppButton button;

  const LoadingIndicator({this.isLoading = false, this.button});
}

class AppHollowButton extends StatelessWidget {
  const AppHollowButton(
      {this.onPressed,
      this.text,
      this.textColor,
      this.color,
      this.height,
      this.isLoading = false,
      this.prefixIcon,
      this.elevation});

  final Function onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final Widget prefixIcon;

  /// The [Height] is 45.0 by default
  final double height;
  final bool isLoading;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 45,
      elevation: 0,
      minWidth: double.infinity,
      onPressed: onPressed,
      color: Colors.transparent,
      textColor: textColor ?? Theme.of(context).buttonColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: color ?? Theme.of(context).buttonColor, width: 1.5),
          borderRadius: BorderRadius.circular(5)),
      child: isLoading
          ? ButtonLoadingIndicator(
              color: textColor ?? Theme.of(context).buttonColor,
              width: 20,
              height: 20,
            )
          : prefixIcon == null
              ? Text(
                  text,
                  style: TextStyle(fontFamily: 'Montserrat'),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: prefixIcon,
                    ),
                    Text(text)
                  ],
                ),
    );
  }
}
