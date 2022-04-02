import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: kswPrimaryColor,
      scaffoldBackgroundColor: kWhite,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 12, right: 8),
        hintStyle: TextStyle(
          color: const Color(0xff828282),
          fontSize: 14.sp,
        ),
        filled: true,
        fillColor: kWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: kGrey1Color,
            width: 0.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: kGrey1Color,
            width: 0.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.5,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(
          color: kAccentBlue,
          width: 1.5,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: Radius.circular(10.0),
        // isAlwaysShown: true,
        // showTrackOnHover: true,
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (states) => kGrey1Color,
        ),
        trackColor: MaterialStateProperty.resolveWith<Color>(
          (states) => kGrey3Color,
        ),
        thickness: MaterialStateProperty.resolveWith<double>(
          (states) => 4.0,
        ),
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 24.sp,
          fontWeight: FontWeight.w900,
        ),
        headline2: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        headline3: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        headline4: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        headline5: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        headline6: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
        bodyText1: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyText2: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: kText1Color,
        ),
        button: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: kPrimaryColor,
        ),
        subtitle1: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: kGrey1Color,
        ),
        subtitle2: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: kGrey1Color,
        ),
        caption: GoogleFonts.inter(
          color: kText1Color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0, 4),
    blurRadius: 30,
  ),
];
