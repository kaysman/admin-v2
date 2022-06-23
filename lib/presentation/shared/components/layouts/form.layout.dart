import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLayout extends StatelessWidget {
  final Widget? body;
  final Widget? footer;
  final double? height;
  final bool? freezeForm;
  const FormLayout({
    Key? key,
    this.body,
    this.footer,
    this.height,
    this.freezeForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: freezeForm ?? false,
      child: Container(
        height: height ?? 600.h,
        width: 520.w,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Expanded(
                  child: body!,
                ),
                footer!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
