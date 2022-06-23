import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class ColorPill extends StatelessWidget {
  final Color? color;
  final String? text;
  const ColorPill({
    Key? key,
    this.color,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        color: color ?? kAccentPurple,
        borderRadius: BorderRadius.circular(50.w),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      child: Center(
        child: Text(
          '$text',
          style: GoogleFonts.inter(
            color: kWhite,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
