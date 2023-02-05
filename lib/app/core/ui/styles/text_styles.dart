import 'package:flutter/material.dart';

const primary = "007D21";
const secundary = "F88B0C";

class TextApp {
  static TextApp? _instance;

  TextApp._();

  static TextApp get i {
    _instance ??= TextApp._();
    return _instance!;
  }

  String get font => 'mplus1';

  TextStyle get textLight => TextStyle(fontFamily: font, fontWeight: FontWeight.w300);

  TextStyle get textRegular => TextStyle(fontFamily: font, fontWeight: FontWeight.normal);

  TextStyle get textMedium => TextStyle(fontFamily: font, fontWeight: FontWeight.w500);

  TextStyle get textSemiBold => TextStyle(fontFamily: font, fontWeight: FontWeight.w600);

  TextStyle get textBold => TextStyle(fontFamily: font, fontWeight: FontWeight.bold);

  TextStyle get textExtraBold => TextStyle(fontFamily: font, fontWeight: FontWeight.w800);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);

  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 28);
}

extension ColorsAppExtensions on BuildContext {
  TextApp get textApp => TextApp.i;
}