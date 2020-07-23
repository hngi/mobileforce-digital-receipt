import 'package:flutter/material.dart';

class DarkMode {
  static final appBarColor = Colors.grey[800];

  static final backgroundColor = Color(0xFF121212);

  static final primaryColor = Color(0xFF80D5FF);

  static final buttonColor = primaryColor;

  static final focusColor = Colors.white;

// Input Text fields
  static final textFieldEnabledColor = Color(0x61FFFFFF);
  static final textFieldFocusedColor = Colors.white;
  static final textFieldRingColor = textFieldEnabledColor;
}

class LightMode {
  static final backgroundColor = Color(0xFFF2F8FF);

  static final appBarColor = primaryColor;

  static final primaryColor = Color(0xFF0B57A7);

  static final buttonColor = primaryColor;

  static final focusColor = textFieldFocusedColor;

// Input Text fields
  static final textFieldEnabledColor = Color(0x99000000);
  static final textFieldFocusedColor = Colors.grey[800];
  static final textFieldRingColor = Color(0x1F000000);
}
