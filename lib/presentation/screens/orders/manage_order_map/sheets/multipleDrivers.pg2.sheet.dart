import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/components/assign_button.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/components/dropdown_search.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/components/sheetBackButton.dart';
import 'package:lng_adminapp/shared.dart';

class AssigningMultipleDriversStep2 extends StatefulWidget {
  const AssigningMultipleDriversStep2({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<AssigningMultipleDriversStep2> createState() =>
      _AssigningMultipleDriversStep2State();
}

class _AssigningMultipleDriversStep2State
    extends State<AssigningMultipleDriversStep2> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetBackButton(
              controller: widget.pageController,
            ),
            Spacings.SMALL_VERTICAL,
            Text(
              "Assign tasks",
              style: Theme.of(context).textTheme.caption,
            ),
            Spacings.SMALL_VERTICAL,
            _buildOverview(context),
            SizedBox(height: 14.sp),
            ...List<Widget>.generate(2, (index) {
              return _buildRoute(context, index + 1);
            }),
            SizedBox(height: 14.sp),
            Align(
              alignment: Alignment.topRight,
              child: AssignButton(
                buttonText: 'Assign task',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
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
            Text(
              "30 task selected",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        )
      ],
    );
  }

  _buildRoute(BuildContext context, int routeCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Route $routeCount",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: kText2Color),
            ),
            Text(
              "Driver assigned 0/3",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        SizedBox(height: 14.sp),
        DropDownSearch(
          isMultipleDrivers: true,
          searchController: _searchController,
        ),
        SizedBox(height: 14.sp),
      ],
    );
  }
}
