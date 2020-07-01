import 'package:flutter/material.dart';


class CustomFormField extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final bool numKeyShow;
  final Function onSubmit;

  const CustomFormField({this.inputController, this.onSubmit, this.hintText, this.numKeyShow });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      onSubmitted: (_) => onSubmit(),
      keyboardType: numKeyShow == null || !numKeyShow ? TextInputType.text : TextInputType.number,
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
            width: 1 ,
          ),
        ),
        focusedBorder: OutlineInputBorder(),
        hintText: hintText == null ? '' : hintText,
        hintStyle: TextStyle(
          color: Color(0xFF979797),
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
      
      obscureText: false,
    );
  }
}