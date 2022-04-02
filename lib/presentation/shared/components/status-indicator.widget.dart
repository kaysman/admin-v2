import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class StatusIndicator extends StatelessWidget {
  final bool isBold;
  final Color color;
  final String? label;
  const StatusIndicator(
      {Key? key, this.isBold = false, this.color = kPrimaryColor, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 8.sp, backgroundColor: color),
        SizedBox(width: 8.w),
        Text(
          "$label",
          style: GoogleFonts.inter(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            fontSize: 16.sp,
            color: kBlack,
          ),
        )
      ],
    );
  }
}
