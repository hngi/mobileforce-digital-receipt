import 'package:flutter/material.dart';

import '../constant.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    this.onPressed,
    this.title,
    this.textColor,
    this.backgroundColor,
  });

  final Function onPressed;
  final String title;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: FlatButton(
        onPressed: onPressed,
        color: backgroundColor,
        textColor: Theme.of(context).textTheme.button.color,
        shape: kRoundedRectangleBorder,
        child: Text(
          title,
        ),
      ),
    );
  }
}
