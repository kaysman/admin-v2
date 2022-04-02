import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class DropDownSearch extends StatelessWidget {
  const DropDownSearch({
    Key? key,
    required this.searchController,
    this.isMultipleDrivers = false,
  }) : super(key: key);

  final bool isMultipleDrivers;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: kGrey3Color, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          // search input
          _buildSearchInput(context),
          // drivers checkboxes
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.only(left: 6.sp),
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Checkbox(value: false, onChanged: (v) {}),
                      Spacings.TINY_HORIZONTAL,
                      Text(
                        'Driver ${index + 1}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSearchInput(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: TextField(
        controller: searchController,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            hoverColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: 'Search drivers',
            hintStyle: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: kGrey1Color),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(
                color: kGrey3Color,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: const BorderSide(
                color: kGrey3Color,
                width: 1,
              ),
            ),
            errorBorder: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.all(10.sp),
              child: AppIcons.svgAsset(
                AppIcons.search,
                color: kGrey1Color,
                height: 24.sp,
              ),
            )),
      ),
    );
  }
}
