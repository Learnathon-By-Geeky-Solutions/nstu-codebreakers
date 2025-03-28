import 'package:flutter/material.dart';

import 'colors.dart';

class AppElevatedButtonTheme {
  static final appLightTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
        AppLightColors.brandColor,
      ),
      minimumSize: const WidgetStatePropertyAll(
        Size(double.infinity, 55),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        Colors.white,
      ),
    ),
  );

  static final appDarkTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const WidgetStatePropertyAll(
        AppDarkColors.brandColor,
      ),
      minimumSize: const WidgetStatePropertyAll(
        Size(double.infinity, 55),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      foregroundColor: const WidgetStatePropertyAll(
        AppDarkColors.textColor,
      ),
    ),
  );
}
