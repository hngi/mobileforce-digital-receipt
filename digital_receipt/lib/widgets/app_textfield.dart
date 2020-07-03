import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.hintText,
    this.keyboardType,
    this.obscureText,
    this.controller,
    this.hintColor,
    this.borderWidth,
  });

  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color hintColor;
  final TextEditingController controller;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller != null ? controller : null,
      style: TextStyle(
        color: Color(0xFF2B2B2B),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.12),
            width: borderWidth == null ? 1 : borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor == null ? Color(0xFF979797) : hintColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
      keyboardType: keyboardType != null ? keyboardType : null,
      obscureText: obscureText != null ? obscureText : false,
    );
  }
}
