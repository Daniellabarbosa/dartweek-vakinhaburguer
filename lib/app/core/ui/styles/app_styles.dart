import 'package:dw23_delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:dw23_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class StylesApp {
  static StylesApp? _instance;

  StylesApp._();

  static StylesApp get i {
    _instance ??= StylesApp._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextApp.i.textButtonLabel,
        foregroundColor: Colors.white,
      );
}

extension AppStylesExtensions on BuildContext {
  StylesApp get stylesApp => StylesApp.i;
}