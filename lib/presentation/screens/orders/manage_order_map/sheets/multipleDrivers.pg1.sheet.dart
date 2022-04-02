import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/components/assign_button.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/components/sheetBackButton.dart';
import 'package:lng_adminapp/shared.dart';

class AssigningMultipleDriversStep1 extends StatefulWidget {
  const AssigningMultipleDriversStep1({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<AssigningMultipleDriversStep1> createState() =>
      _AssigningMultipleDriversStep1State();
}

class _AssigningMultipleDriversStep1State
    extends State<AssigningMultipleDriversStep1> {
  late TextEditingController _maxNumberController;
  late TextEditingController _minNumberController;
  late TextEditingController _driversController;

  @override
  void initState() {
    _maxNumberController = TextEditingController();
    _minNumberController = TextEditingController();
    _driversController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
        ..._buildOverview(context),
        SizedBox(height: 14.sp),
        ..._buildDeliveryAllocation(context),
        SizedBox(height: 14.sp),
        Align(
          alignment: Alignment.topRight,
          child: AssignButton(
            buttonText: 'Assign task',
            onPressed: () {
              if (widget.pageController.page != 1) {
                widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate);
              }
            },
          ),
        ),
      ],
    );
  }

  _buildOverview(BuildContext context) {
    return [
      Text(
        "Overview",
        style:
            Theme.of(context).textTheme.bodyText2?.copyWith(color: kText2Color),
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
      ),
    ];
  }

  _buildDeliveryAllocation(BuildContext context) {
    return [
      Text(
        "Delivery Allocation",
        style:
            Theme.of(context).textTheme.bodyText2?.copyWith(color: kText2Color),
      ),
      _LabeledInput(
        text1: 'Max. number of deliveries per driver',
        text2: 'deliveries',
        controller: _maxNumberController,
      ),
      _LabeledInput(
        text1: 'Min. number of deliveries per driver',
        text2: 'deliveries',
        controller: _minNumberController,
      ),
      _LabeledInput(
        text1: 'No. of drivers to allocate ',
        text2: 'drivers',
        controller: _driversController,
      ),
    ];
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({
    Key? key,
    required this.text1,
    required this.text2,
    required this.controller,
  }) : super(key: key);

  final String text1;
  final String text2;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 14.sp),
        Text(
          text1,
          style: Theme.of(context).textTheme.caption,
        ),
        Spacings.TINY_VERTICAL,
        Row(
          children: [
            SizedBox(
              height: 33.h,
              width: 80.w,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  fillColor: kWhite,
                ),
              ),
            ),
            Spacings.TINY_HORIZONTAL,
            Text(
              text2,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
