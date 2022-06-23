import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

import '../components/assign_button.dart';
import '../components/dropdown_search.dart';
import '../components/sheetBackButton.dart';
import '../options.dart';

class Assign1DriverSheet extends StatefulWidget {
  const Assign1DriverSheet({Key? key}) : super(key: key);

  @override
  State<Assign1DriverSheet> createState() => _Assign1DriverSheetState();
}

class _Assign1DriverSheetState extends State<Assign1DriverSheet> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: optionsWidth,
      padding: const EdgeInsets.symmetric(
        vertical: Spacings.kSpaceNormal,
        horizontal: Spacings.kSpaceSmall,
      ),
      decoration: BoxDecoration(
        boxShadow: kBoxShadow,
        color: kWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetBackButton(),
          Spacings.SMALL_VERTICAL,
          Text(
            "Assign tasks",
            style: Theme.of(context).textTheme.caption,
          ),
          Spacings.SMALL_VERTICAL,
          _buildOverview(context),
          SizedBox(height: 14.sp),
          _buildAssignDriver(context),
          SizedBox(height: 14.sp),
          Align(
            alignment: Alignment.topRight,
            child: AssignButton(
              buttonText: 'Assign task',
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1. Overview",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: kText2Color),
        ),
        SizedBox(height: 14.sp),
        Row(
          children: [
            CircleAvatar(radius: 3.5, backgroundColor: kAccentBlue),
            SizedBox(width: 10.sp),
            Text("1 task selected", style: Theme.of(context).textTheme.caption),
          ],
        )
      ],
    );
  }

  _buildAssignDriver(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. Assign driver",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: kText2Color),
        ),
        SizedBox(height: 14.sp),
        DropDownSearch(
          searchController: _searchController,
        ),
      ],
    );
  }
}
