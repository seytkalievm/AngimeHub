import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = "", Icon icon = const Icon(Icons.input)}) {
    return InputDecoration(
      prefixIcon: icon,
      contentPadding: const EdgeInsets.all(12),
      fillColor: const Color.fromARGB(255, 42, 45, 71),
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      hintText: hintTextStr,
      hintStyle: const TextStyle(
          fontFamily: "Open Sans", color: Color.fromARGB(255, 133, 135, 159)),
    );
  }

  static TextStyle descriptionTextStyle() {
    return const TextStyle(
      fontFamily: "Open Sans",
      color: Color.fromARGB(255, 133, 135, 159),
    );
  }

  static TextStyle headingTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 28,
    );
  }

  static TextStyle textFieldInputStyle() {
    return const TextStyle(
      fontFamily: "Open Sans",
      color: Colors.white,
    );
  }

  static Color mainColor(){
    return const Color.fromARGB(255, 20, 22, 38);
  }
  static Color secondaryColor(){
    return const Color.fromARGB(255, 42, 45, 71);
  }

  static ThemeData mainTheme(){
    return ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 20, 22, 38),
      fontFamily: "Open Sans",
    );
  }
}
