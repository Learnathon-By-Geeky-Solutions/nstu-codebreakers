import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextThemeExtension on TextTheme {
  TextStyle get text3xlBold => GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w900,
      );
  TextStyle get text3xlSemiBold => GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w700,
      );
  TextStyle get text3xlMedium => GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w500,
      );
  TextStyle get text3xlRegular => GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w400,
      );

  TextStyle get text2xlBold => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w900,
      );
  TextStyle get text2xlSemiBold => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      );
  TextStyle get text2xlMedium => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w500,
      );
  TextStyle get text2xlRegular => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w400,
      );
  TextStyle get textxlBold => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w900,
      );
  TextStyle get textxlSemiBold => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );
  TextStyle get textxlMedium => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
      );
  TextStyle get textxlRegular => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w400,
      );
  TextStyle get textlgBold => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w900,
      );
  TextStyle get textlgSemiBold => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );
  TextStyle get textlgMedium => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      );
  TextStyle get textlgRegular => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w400,
      );
  TextStyle get textBaseBold => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w900,
      );
  TextStyle get textBaseSemiBold => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );
  TextStyle get textBaseMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  TextStyle get textBaseRegular => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
  TextStyle get textSmBold => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w900,
      );
  TextStyle get textSmSemiBold => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      );
  TextStyle get textSmMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
  TextStyle get textSmRegular => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );
  TextStyle get textXsBold => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w900,
      );
  TextStyle get textXsSemiBold => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w700,
      );
  TextStyle get textXsMedium => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
  TextStyle get textXsRegular => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
  TextStyle get text2xsBold => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w900,
      );
  TextStyle get text2xsSemiBold => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w700,
      );
  TextStyle get text2xsMedium => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      );
  TextStyle get text2xsRegular => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      );
}

extension on Column {
  paddingOnly(double left, double top, double right, double bottom) {
    return Padding(
      padding:
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }
}
