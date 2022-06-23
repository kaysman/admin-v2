import 'package:flutter/material.dart';
import 'package:lng_adminapp/shared.dart';
import '../options.dart';
import 'multipleDrivers.pg1.sheet.dart';
import 'multipleDrivers.pg2.sheet.dart';

class AssignMultipleDrivers extends StatefulWidget {
  const AssignMultipleDrivers({Key? key}) : super(key: key);

  @override
  State<AssignMultipleDrivers> createState() => _AssignMultipleDriversState();
}

class _AssignMultipleDriversState extends State<AssignMultipleDrivers> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
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
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          AssigningMultipleDriversStep1(pageController: _pageController),
          AssigningMultipleDriversStep2(pageController: _pageController),
        ],
      ),
    );
  }
}
