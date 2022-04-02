import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/shared.dart';

class PickupAcceptingDialog extends StatefulWidget {
  PickupAcceptingDialog({Key? key}) : super(key: key);

  @override
  State<PickupAcceptingDialog> createState() => _PickupAcceptingDialogState();
}

class _PickupAcceptingDialogState extends State<PickupAcceptingDialog> {
  final _pageViewController = PageController();

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.279.sw,
      color: kWhite,
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 32,
      ),
      child: ExpandablePageView(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _PickupDetails(pageController: _pageViewController),
          _DropoffDetails(pageController: _pageViewController),
        ],
      ),
    );
  }
}

class _PickupDetails extends StatefulWidget {
  const _PickupDetails({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<_PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<_PickupDetails> {
  late TextEditingController _pickupTimeController;
  late TextEditingController _closeTimeController;
  bool customAddress = false;

  late List<String> hours;
  String? _pickupTime;
  String? _closeTime;
  String? _merchantWarehouse;

  @override
  void initState() {
    _pickupTimeController = TextEditingController();
    _closeTimeController = TextEditingController();

    hours = hoursIn12HourSystem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, _setState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, color: kBlack),
              ),
              Text(
                "Pickup details",
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                "1/3",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: kText2Color),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          RowOfTwoChildren(
            child1: LabeledHourSelectInput(
              label: "Pickup time",
              value: _pickupTime,
              onSelected: (v) {
                _setState(() {
                  _pickupTime = v;
                });
              },
              items: hours,
            ),
            child2: LabeledHourSelectInput(
              label: "Close time",
              value: _closeTime,
              onSelected: (v) {
                _setState(() {
                  _closeTime = v;
                });
              },
              items: hours,
            ),
          ),
          SizedBox(height: 16.sp),
          if (!customAddress)
            // LabeledRadioDropdown(
            //   label: "Merchant warehouse",
            //   value: _merchantWarehouse,
            //   onSelected: (String v) => _setState(() {
            //     _merchantWarehouse = v;
            //   }),
            //   items: dummyWareHouses,
            // ),
            if (!customAddress) SizedBox(height: 16.sp),
          if (customAddress) ...[
            LabeledInput(
              label: "Address line 1",
              hintText: "Address line 1",
              controller: _pickupTimeController,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "Address line 2 (optional)",
              hintText: "Address line 2",
              controller: _pickupTimeController,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "Postal code",
              hintText: "Postal code",
              controller: _pickupTimeController,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "City",
              hintText: "City",
              controller: _pickupTimeController,
            ),
            SizedBox(height: 16.sp),
            LabeledInput(
              label: "Country",
              hintText: "Country",
              controller: _pickupTimeController,
            ),
          ],
          Row(
            children: [
              Checkbox(
                value: customAddress,
                onChanged: (v) {
                  setState(() {
                    customAddress = !customAddress;
                  });
                },
              ),
              SizedBox(width: 6.sp),
              Text(
                "Custom address",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          Button(
            primary: kPrimaryColor,
            textColor: kWhite,
            text: "Next",
            onPressed: () {
              widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate);
            },
          ),
        ],
      );
    });
  }
}

class _DropoffDetails extends StatefulWidget {
  const _DropoffDetails({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<_DropoffDetails> createState() => _DropoffDetailsState();
}

class _DropoffDetailsState extends State<_DropoffDetails> {
  late TextEditingController _pickupTimeController;
  late TextEditingController _closeTimeController;
  bool customAddress = false;

  @override
  void initState() {
    _pickupTimeController = TextEditingController();
    _closeTimeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, color: kBlack),
            ),
            Text(
              "Drop-off details",
              style: Theme.of(context).textTheme.headline2,
            ),
            Text(
              "2/3",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: kText2Color),
            ),
          ],
        ),
        SizedBox(height: 16.sp),
        RowOfTwoChildren(
          child1: LabeledInput(
            label: "Drop-off time",
            controller: _pickupTimeController,
            suffixIcon: AppIcons.svgAsset(AppIcons.clock),
          ),
          child2: LabeledInput(
            label: "Closing time",
            controller: _closeTimeController,
            suffixIcon: AppIcons.svgAsset(AppIcons.clock),
          ),
        ),
        SizedBox(height: 16.sp),
        if (!customAddress)
          LabeledInput(
            label: "Drop-off location",
            controller: _pickupTimeController,
          ),
        if (!customAddress) SizedBox(height: 16.sp),
        if (customAddress) ...[
          LabeledInput(
            label: "Address line 1",
            hintText: "Address line 1",
            controller: _pickupTimeController,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "Address line 2 (optional)",
            hintText: "Address line 2",
            controller: _pickupTimeController,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "Postal code",
            hintText: "Postal code",
            controller: _pickupTimeController,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "City",
            hintText: "City",
            controller: _pickupTimeController,
          ),
          SizedBox(height: 16.sp),
          LabeledInput(
            label: "Country",
            hintText: "Country",
            controller: _pickupTimeController,
          ),
        ],
        Row(
          children: [
            Checkbox(
              value: customAddress,
              onChanged: (v) {
                setState(() {
                  customAddress = !customAddress;
                });
              },
            ),
            SizedBox(width: 6.sp),
            Text(
              "Custom address",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        SizedBox(height: 16.sp),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              primary: kPrimaryColor,
              textColor: kWhite,
              text: "Back",
              onPressed: () {
                widget.pageController.previousPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                );
              },
            ),
            SizedBox(width: 16.sp),
            Button(
              primary: kPrimaryColor,
              textColor: kWhite,
              text: "Next",
              onPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.decelerate,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
