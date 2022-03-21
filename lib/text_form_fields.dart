
import 'package:angimehub/styles.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget{
  MyTextFormField(this.hintText, this.validator,
      {Key? key, this.isObscure = false}) : super(key: key);

  final bool isObscure;
  final String hintText;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      style: CommonStyle.textFieldInputStyle(),
      decoration: CommonStyle.textFieldStyle(hintTextStr: hintText),
      cursorColor: Colors.white,
      validator: (value){
        validator;
        return null;
      },
    );
  }



}