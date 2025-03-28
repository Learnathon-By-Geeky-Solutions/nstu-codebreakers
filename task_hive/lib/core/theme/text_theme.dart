import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static final textLightTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppLightColors.brandColor,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppLightColors.textColor,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppLightColors.textColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: AppLightColors.textColor,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppLightColors.textColor,
    ),
  );

  static final textDarkTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppDarkColors.brandColor,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppDarkColors.textColor,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppDarkColors.textColor,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: AppDarkColors.textColor,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppDarkColors.textColor,
    ),
  );
}

// class MyTextTheme {
//   static final myLightTextTheme = TextTheme(
//     headlineLarge: GoogleFonts.poppins(
//       fontSize: 24,
//       fontWeight: FontWeight.w700,
//       // color: AppColors.dark,
//     ),
//     headlineSmall: GoogleFonts.poppins(
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       // color: AppColors.dark,
//     ),
//     bodyLarge: GoogleFonts.poppins(
//       fontSize: 16,
//       fontWeight: FontWeight.w500,
//       // color: AppColors.dark,
//     ),
//     bodyMedium: GoogleFonts.poppins(
//       fontSize: 12,
//       fontWeight: FontWeight.w300,
//       // color: AppColors.dark,
//     ),
//     bodySmall: GoogleFonts.poppins(
//       fontSize: 11,
//       fontWeight: FontWeight.w500,
//       // color: AppColors.dark,
//     ),
//   );
//   static final myDarkTextTheme = TextTheme(
//     headlineLarge: GoogleFonts.poppins(
//       fontSize: 24,
//       fontWeight: FontWeight.w700,
//       // color: AppColors.dark,
//     ),
//     headlineSmall: GoogleFonts.poppins(
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       // color: AppColors.dark,
//     ),
//     bodyLarge: GoogleFonts.poppins(
//       fontSize: 16,
//       fontWeight: FontWeight.w500,
//       // color: AppColors.dark,
//     ),
//     bodyMedium: GoogleFonts.poppins(
//       fontSize: 12,
//       fontWeight: FontWeight.w300,
//       // color: AppColors.dark,
//     ),
//     bodySmall: GoogleFonts.poppins(
//       fontSize: 11,
//       fontWeight: FontWeight.w500,
//       // color: AppColors.dark,
//     ),
//   );
// }
