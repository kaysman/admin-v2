import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class ResponseDialog extends StatefulWidget {
  final String? message;
  final Function()? onClose;
  final DialogType? type;
  final Widget? extra;
  ResponseDialog({
    Key? key,
    this.message,
    this.onClose,
    this.type,
    this.extra,
  }) : super(key: key);

  @override
  _ResponseDialogState createState() => _ResponseDialogState();
}

class _ResponseDialogState extends State<ResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      width: 375.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.onClose,
                child: SvgPicture.asset('assets/svg/times.svg'),
              ),
              SizedBox(),
            ],
          ),
          SizedBox(height: 8.h),
          SvgPicture.asset(
            'assets/svg/success.svg',
            height: 60.w,
            width: 60.w,
          ),
          SizedBox(height: 10.h),
          Text(
            '${widget.message}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: kBlack,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          if (widget.extra != null) ...[
            widget.extra!
          ] else ...[
            Button(
              text: 'Close',
              borderColor: kPrimaryColor,
              textColor: kWhite,
              onPressed: widget.onClose,
              primary: kPrimaryColor,
            ),
          ],
        ],
      ),
    );
  }
}
