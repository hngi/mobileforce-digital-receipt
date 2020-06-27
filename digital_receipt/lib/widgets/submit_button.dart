import 'package:flutter/material.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child:
            /* _loadingSpinner
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            value,
                          )
                        :  */
            Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        color: backgroundColor,
      ),
    );
  }
}
