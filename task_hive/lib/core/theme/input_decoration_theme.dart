import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppInputDecorationTheme {
  static final appInputDecorationTheme = InputDecorationTheme(
    filled: false,
    hintStyle: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: AppColors.brand.withOpacity(0.2),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColors.brand,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: AppColors.alert,
        width: 2,
      ),
    ),
  );

  // static final myDarkInputDecorationTheme = InputDecorationTheme(
  //   filled: true,
  //   // fillColor: const Color(0xFFEBD9CA),
  //   hintStyle: GoogleFonts.poppins(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w300,
  //     color: AppColors.grey,
  //   ),
  //   enabledBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(15),
  //     borderSide: BorderSide.none,
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(15),
  //     borderSide: const BorderSide(
  //       color: AppColors.brand,
  //       width: 2,
  //     ),
  //   ),
  //   errorBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(15),
  //     borderSide: BorderSide.none,
  //   ),
  //   focusedErrorBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(15),
  //     borderSide: const BorderSide(
  //       color: AppColors.alert,
  //       width: 2,
  //     ),
  //   ),
  // );
}
