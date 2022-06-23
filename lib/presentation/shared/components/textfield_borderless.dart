import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../icons.dart';

class TextFieldNoBorder extends StatelessWidget {
  const TextFieldNoBorder({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 4),
            AppIcons.svgAsset(AppIcons.search),
            SizedBox(width: 4),
            SizedBox(
              width: 257.sp,
              child: TextFormField(
                scrollPadding: EdgeInsets.zero,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: Theme.of(context).textTheme.subtitle2,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  filled: false,
                  isDense: true,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: this.onChanged,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Divider(
            indent: 0,
            endIndent: 0,
          ),
        ),
      ],
    );
  }
}
