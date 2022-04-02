import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class EditFlowButton extends StatelessWidget {
  const EditFlowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: FlatButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.svgAsset(AppIcons.edit),
            SizedBox(
              width: 8,
            ),
            Text('Edit Operational Flow',
                style: GoogleFonts.inter(
                    color: kPrimaryColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
