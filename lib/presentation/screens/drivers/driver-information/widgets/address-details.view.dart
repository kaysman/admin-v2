import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class AddressDetails extends StatelessWidget {
  final String? address;
  final String? postalCode;
  final String? city;
  final String? country;
  const AddressDetails({
    Key? key,
    this.address,
    this.postalCode,
    this.city,
    this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address Details',
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
            Details(title: 'Address', value: '${address ?? '-'}'),
            Details(title: 'Postal Code', value: '${postalCode ?? '-'}'),
            Details(title: 'City', value: '${city ?? '-'}'),
            Details(title: 'Country', value: '${country ?? '-'}'),
          ],
        )
      ],
    );
  }
}
