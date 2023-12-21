import 'package:flutter/material.dart';

class AppTheme {
  static const Color dark = Color(0xff000000);
  static const Color medium = Color(0x56ffffff);
  static const Color light = Color(0xffffffff);
  static const Color accent = Color(0xffffa500);
  static const Color disableBackgroundColor = Colors.black12;
  static const Color disableForegroundColor = Colors.white12;
  static const TextStyle inputStyle = TextStyle(color: light, fontSize: 20);
  static const TextStyle hintStyle = TextStyle(color: medium);
  static const TextStyle counterStyle = TextStyle(color: medium, fontSize: 14);
  static const TextStyle splashStyle = TextStyle(
    color: accent,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: accent,
    foregroundColor: light,
    disabledBackgroundColor: disableBackgroundColor,
    disabledForegroundColor: disableForegroundColor,
  );

  ButtonStyle get getElevatedButtonStyle {
    return elevatedButtonStyle;
  }
}
