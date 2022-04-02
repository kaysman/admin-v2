import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class ViewContentLayout extends StatelessWidget {
  final Color? color;
  final String? title;
  final List<Widget>? content;
  final double? height;
  final Widget? footer;
  final bool? freezeContent;
  final double? margin;
  const ViewContentLayout({
    Key? key,
    this.color,
    this.title,
    this.content,
    this.footer,
    this.height,
    this.freezeContent,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: freezeContent ?? false,
      child: Container(
        width: 520.w,
        height: height ?? 600.h,
        padding: EdgeInsets.only(
          left: 24.w,
          top: 24.w,
          right: 8.w,
          bottom: 24.w,
        ),
        margin: EdgeInsets.all(margin ?? 24.w),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 45.r,
              color: const Color(0xff000000).withOpacity(0.1),
            ),
          ],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: color ?? kWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                '$title',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content!,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            if (footer != null) ...[
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: footer!,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
