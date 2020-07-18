import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppTextFieldForm extends StatelessWidget {
  const AppTextFieldForm(
      {this.hintText,
      this.keyboardType,
      this.obscureText,
      this.controller,
      this.validator,
      this.height,
      this.hintColor,
      this.borderWidth,
      this.onTap,
      this.onSaved,
      this.focusNode,
      this.textInputAction,
      this.onFieldSubmitted});

  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color hintColor;
  final TextEditingController controller;
  final double borderWidth;
  final double height;
  final Function(String) validator;
  final Function onSaved;
  final Function onTap;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller != null ? controller : null,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
        height: height,
        color: Color(0xFF2B2B2B),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
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
