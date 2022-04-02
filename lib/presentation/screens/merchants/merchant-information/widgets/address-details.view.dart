import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class CompanyDetails extends StatelessWidget {
  final String? companyName;
  final String? address;
  final String? postalCode;
  final String? city;
  final String? country;
  final String? phone;
  final String? vat;
  const CompanyDetails({
    Key? key,
    this.address,
    this.postalCode,
    this.city,
    this.country,
    this.companyName,
    this.phone,
    this.vat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Company Details',
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
            Details(title: 'Company Name', value: '${companyName ?? '-'}'),
            Details(title: 'Address', value: '${address ?? '-'}'),
            Details(title: 'Postal Code', value: '${postalCode ?? '-'}'),
            Details(title: 'City', value: '${city ?? '-'}'),
            Details(title: 'Country', value: '${country ?? '-'}'),
            Details(title: 'Phone (office)', value: '${phone ?? '-'}'),
            Details(title: 'VAT/GST ID', value: '${vat ?? '-'}'),
          ],
        )
      ],
    );
  }
}
