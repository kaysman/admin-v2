import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class TopViewDefiningWidget extends StatelessWidget {
  const TopViewDefiningWidget({
    Key? key,
    required this.onViewChanged,
  }) : super(key: key);

  final VoidCallback onViewChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewChanged,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          boxShadow: kBoxShadow,
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.svgAsset(AppIcons.table, color: kText1Color),
            Spacings.TINY_HORIZONTAL,
            Text("Table view",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
