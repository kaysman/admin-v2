import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class LabelOfDetails extends StatelessWidget {
  const LabelOfDetails({
    Key? key,
    required this.label,
    this.onTap,
    this.isDisabled = false,
  }) : super(key: key);

  final String label;
  final Function()? onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isDisabled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label details",
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
          if (onTap != null)
            InkWell(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    color: isDisabled ? kGrey1Color : kPrimaryColor,
                    size: 14.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Edit details",
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: isDisabled ? kGrey1Color : kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
