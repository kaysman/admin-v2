import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class PersonalDetails extends StatelessWidget {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;

  const PersonalDetails({
    Key? key,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Personal Details',
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18.h,
          ),
          CircleAvatar(
            radius: 32.r,
            child: photoUrl == null ? SizedBox() : Image.network(photoUrl!),
          ),
          SizedBox(
            height: 18.h,
          ),
          Details(title: 'Name', value: '${name ?? '-'}'),
          Details(title: 'Email', value: '${email ?? '-'}'),
          Details(title: 'Phone Number', value: '${phoneNumber ?? '-'}'),
          SizedBox(
            height: 8.h,
          ),
        ],
      )
    ]);
  }
}
