import 'package:flutter/material.dart';

import '../constant.dart';
import 'button_loading_indicator.dart';

class AppSolidButton extends StatelessWidget {
  const AppSolidButton({
    this.onPressed,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.height,
    this.isLoading = false,
  });

  final Function onPressed;
  final String text;
  final Color textColor;
  final Color backgroundColor;

  /// The [Height] is 45.0 by default
  final double height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height ?? 45,
      minWidth: double.infinity,
      onPressed: onPressed,
      color: Theme.of(context).buttonColor,
      textColor: Theme.of(context).textTheme.button.color,
      shape: kRoundedRectangleBorder,
      child: isLoading
          ? ButtonLoadingIndicator(
              color: Theme.of(context).textTheme.button.color,
              width: 20,
              height: 20,
            )
          : Text(
              text,
            ),
    );
  }
}
