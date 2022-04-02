import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';
import 'details.dart';

class PermissionDetails extends StatelessWidget {
  final List<String>? permissions;
  const PermissionDetails({Key? key, this.permissions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List of permissions',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...permissions!.map(
              (permission) => Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  '${permission}',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: kBlack,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
