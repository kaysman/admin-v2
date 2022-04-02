import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class ContactDetails extends StatelessWidget {
  final String? name;
  final String? phoneNumber;
  final String? emailAddress;
  const ContactDetails({
    Key? key,
    this.name,
    this.phoneNumber,
    this.emailAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Contact Details',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 16.h,
      ),
      Column(
        children: [
          Details(
            title: 'Name',
            value: '${name ?? '-'}',
          ),
          Details(
            title: 'Email',
            value: '${emailAddress ?? '-'}',
          ),
          Details(
            title: 'Phone Number',
            value: '${phoneNumber ?? '-'}',
          ),
        ],
      )
    ]);
  }
}
