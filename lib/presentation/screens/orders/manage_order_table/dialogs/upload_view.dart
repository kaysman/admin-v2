import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';
import 'excel_upload.dart';
import 'single_upload.dart';

class UploadViewModal extends StatelessWidget {
  const UploadViewModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Upload Order',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: Button(
              text: "Upload single order",
              hasBorder: true,
              verticalPadding: 14.0,
              borderColor: kGrey3Color,
              textColor: kBlack,
              onPressed: () {
                Navigator.pop(context);
                showWhiteDialog(context, UploadSingleDialog());
              },
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: Button(
              text: "Upload via excel sheet",
              borderColor: kGrey3Color,
              textColor: kBlack,
              hasBorder: true,
              onPressed: () {
                showWhiteDialog(context, UploadExcelDialog());
              },
            ),
          ),
          SizedBox(height: 24.h),
          Button(
            text: "Close",
            primary: kPrimaryColor,
            hasBorder: false,
            textColor: kWhite,
            elevation: 0,
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: () {},
            child: Text("View upload history"),
          ),
        ],
      ),
    );
  }
}
