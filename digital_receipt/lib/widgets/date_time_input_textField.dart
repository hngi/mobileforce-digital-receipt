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
      readOnly: true,
      style: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0xFFC8C8C8),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(),
      ),
    );
  }
}
