import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components.dart';

class BackContentLayout extends StatelessWidget {
  @required
  final Widget? child;
  const BackContentLayout({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGrey3Color,
      padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatBackButton(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          child!
        ],
      ),
    );
  }
}
