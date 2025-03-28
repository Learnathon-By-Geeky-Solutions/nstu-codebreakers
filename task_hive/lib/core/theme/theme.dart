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
      color: AppLightColors.surface,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppLightColors.brandColor,
      secondary: AppLightColors.headerColor,
      tertiary: AppLightColors.subHeaderColor,
      surface: AppLightColors.surface,
      error: AppLightColors.alert,
    ),
    textTheme: AppTextTheme.textLightTheme,
    inputDecorationTheme: AppInputDecorationTheme.appLightTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.appLightTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppDarkColors.surface,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppDarkColors.brandColor,
      secondary: AppDarkColors.headerColor,
      tertiary: AppDarkColors.subHeaderColor,
      surface: AppDarkColors.surface,
      error: AppDarkColors.alert,
    ),
    textTheme: AppTextTheme.textDarkTheme,
    inputDecorationTheme: AppInputDecorationTheme.appDarkTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.appDarkTheme,
  );
}
