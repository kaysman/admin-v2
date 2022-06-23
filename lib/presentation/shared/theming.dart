import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: kswPrimaryColor,
      scaffoldBackgroundColor: kWhite,
      dataTableTheme: DataTableThemeData(
        checkboxHorizontalMargin: 18.w,
        headingRowColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return kSecondaryColor.withOpacity(0.6);
            }
            return kSecondaryColor;
          },
        ),
        dataRowColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return kGrey5Color;
            }
            return kWhite;
          },
        ),
        dataRowHeight: 46,
        headingTextStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dataTextStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        dividerThickness: 0.4.sp,
        headingRowHeight: 46,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 12, right: 8),
        // hintStyle: Theme.of(context)
        //     .textTheme
        //     .bodyText1!
        //     .copyWith(color: Colors.black54),
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
      textTheme: GoogleFonts.interTextTheme(
        TextTheme(
          headline1: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          headline2: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          headline3: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          headline4: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          headline5: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          headline6: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyText2: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kText1Color,
          ),
          button: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kPrimaryColor,
          ),
          subtitle1: GoogleFonts.inter(
            fontSize: 16, // TextField text style uses this by default
            fontWeight: FontWeight.w400,
            color: kGrey1Color,
          ),
          subtitle2: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: kGrey1Color,
          ),
          caption: GoogleFonts.inter(
            color: kText1Color,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
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
