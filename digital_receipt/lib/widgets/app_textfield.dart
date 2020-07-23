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
      this.onFieldSubmitted,
      this.suffixIcon});

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
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller != null ? controller : null,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
          ),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType != null ? keyboardType : null,
      obscureText: obscureText != null ? obscureText : false,
    );
  }
}
