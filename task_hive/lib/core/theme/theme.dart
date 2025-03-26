import 'package:flutter/material.dart';

import 'colors.dart';
import 'elevated_button_theme.dart';
import 'input_decoration_theme.dart';
import 'text_theme.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    // colorScheme: const ColorScheme.light(
    //   primary: MyLightColors.primary,
    //   secondary: MyLightColors.secondary,
    //   shadow: MyLightColors.shadow,
    // ),
    // textTheme: MyTextTheme.myLightTextTheme,
    inputDecorationTheme: AppInputDecorationTheme.appInputDecorationTheme,
    elevatedButtonTheme: MyElevatedfButtonTheme.myElevatedfButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // colorScheme: const ColorScheme.dark(
    //   primary: MyDarkColors.primary,
    //   secondary: MyDarkColors.secondary,
    //   shadow: MyDarkColors.shadow,
    // ),
    // appBarTheme: const AppBarTheme(
    //   foregroundColor: MyLightColors.surface,
    // ),
    // textTheme: MyTextTheme.myDarkTextTheme,
    inputDecorationTheme: AppInputDecorationTheme.appInputDecorationTheme,
    // elevatedButtonTheme: MyElevatedfButtonTheme.myElevatedfButtonTheme,
  );
}
