import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF320f6e,
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(0xFF320f6e),
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF311B92),
    },
  );
  static const darkBlue = Color.fromARGB(255, 5, 15, 56);
  static const primary = Color.fromARGB(255, 50, 15, 110);
  static const secondary = Color.fromARGB(255, 33, 175, 229);
  static const white = Colors.white;
  static const black = Colors.black;
  static const white60 = Color.fromRGBO(255, 255, 255, 0.6);
  static const black60 = Color.fromRGBO(0, 0, 0, 0.6);
  static const transparent = Colors.transparent;
  static const green = Color.fromARGB(255, 0, 255, 0);
  static const yellow = Color.fromARGB(255, 255, 255, 0);
  static const red = Color.fromARGB(255, 255, 0, 0);
  static const darkRed = Color.fromARGB(155, 255, 0, 0);
  static const grey = Color.fromARGB(255, 155, 155, 155);
  static const blue = Color.fromARGB(255, 38, 70, 175);
  static const orange = Color.fromARGB(255, 226, 131, 18);
}
