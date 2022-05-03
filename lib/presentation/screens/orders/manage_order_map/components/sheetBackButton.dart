import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class SheetBackButton extends StatelessWidget {
  const SheetBackButton({
    Key? key,
    this.controller,
  }) : super(key: key);

  final PageController? controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (controller != null) {
          if (controller?.page?.toInt() == 0) {
            Navigator.of(context).pop();
            return;
          }
          controller?.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.decelerate);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: kGrey1Color,
            size: 18.sp,
          ),
          SizedBox(width: Spacings.kSpaceTiny),
          Text(
            'Back',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
