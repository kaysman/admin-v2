import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/details.dart';

class VehicleDetails extends StatelessWidget {
  final VehicleType type;
  final String? model;
  final String? year;
  final String? licensePlate;
  final String? color;

  const VehicleDetails({
    Key? key,
    required this.type,
    this.model,
    this.year,
    this.licensePlate,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Vehicle Details',
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
            title: 'Vehicle Type',
            value: type.name,
          ),
          Details(
            title: 'Vehicle Model',
            value: '${model ?? '-'}',
          ),
          Details(
            title: 'Model Year',
            value: '${year ?? '-'}',
          ),
          Details(
            title: 'License Plate',
            value: '${licensePlate ?? '-'}',
          ),
          Details(
            title: 'Vehicle Colour',
            value: '${color ?? '-'}',
          ),
        ],
      )
    ]);
  }
}
