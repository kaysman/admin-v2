import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class TrackingDetails extends StatelessWidget {
  final String? phone;
  final String? email;
  const TrackingDetails({
    Key? key,
    this.phone,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking Details',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Column(
          children: [
            Details(title: 'Phone', value: '${phone ?? '-'}'),
            Details(title: 'Email', value: '${email ?? '-'}'),
          ],
        )
      ],
    );
  }
}
