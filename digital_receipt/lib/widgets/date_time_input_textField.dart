import 'package:flutter/material.dart';

class DateTimeInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onTap;

  const DateTimeInputTextField({
    Key key,
    this.controller,
    this.onTap,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(
        fontFamily: 'Montserrat'
      ),
      readOnly: true,
      onTap: onTap,
    );
  }
}
