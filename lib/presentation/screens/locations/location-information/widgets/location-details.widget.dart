import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class LocationDetails extends StatelessWidget {
  final String? name;
  final String? type;
  final String? address;
  final String? postalCode;
  final String? city;
  final String? country;
  const LocationDetails({
    Key? key,
    this.name,
    this.type,
    this.address,
    this.postalCode,
    this.city,
    this.country,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Location Details',
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
            title: 'Location name',
            value: '${name ?? '-'}',
          ),
          Details(
            title: 'Location type',
            value: '${type ?? '-'}',
          ),
          Details(
            title: 'Address',
            value: '${address ?? '-'}',
          ),
          Details(
            title: 'Postal code',
            value: '${postalCode ?? '-'}',
          ),
          Details(
            title: 'City',
            value: '${city ?? '-'}',
          ),
          Details(
            title: 'Country',
            value: '${country ?? '-'}',
          ),
        ],
      )
    ]);
  }
}
