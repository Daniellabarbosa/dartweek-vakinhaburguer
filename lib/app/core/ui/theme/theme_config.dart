import 'package:dw23_delivery_app/app/core/ui/styles/app_styles.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

const primary = "007D21";
const secundary = "F88B0C";

class ThemeConfig {
  static ThemeConfig? _instance;

  ThemeConfig._();

  static ThemeConfig get i {
    _instance ??= ThemeConfig._();
    return _instance!;
  }

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(
      color: Colors.grey[400]!,
    ),
  );

  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorsApp.i.primary,
          primary: ColorsApp.i.primary,
          secondary: ColorsApp.i.secundary,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        primaryColor: ColorsApp.i.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: StylesApp.i.primaryButton,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(13),
          border: _defaultInputBorder,
          enabledBorder: _defaultInputBorder,
          focusedBorder: _defaultInputBorder,
          labelStyle: TextApp.i.textRegular.copyWith(color: Colors.black),
          errorStyle: TextApp.i.textRegular.copyWith(color: Colors.redAccent),
        ),
      );
}

extension ThemeAppExtensions on BuildContext {
  ThemeConfig get themeConfig => ThemeConfig.i;
}