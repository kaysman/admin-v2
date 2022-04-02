import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';
import 'select_orders.dart';

class _PickupRequesting extends StatefulWidget {
  const _PickupRequesting({Key? key}) : super(key: key);

  @override
  State<_PickupRequesting> createState() => _PickupRequestingState();
}

class _PickupRequestingState extends State<_PickupRequesting> {
  late TextEditingController _controller;
  bool _showTable = false;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.decelerate,
      duration: const Duration(milliseconds: 600),
      child: _showTable
          ? SelectPickupOrders()
          : Container(
              color: kGrey5Color,
              padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pickups",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: 0.35.sw,
                    height: 449.sp,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      boxShadow: kBoxShadow,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Request Pickup',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabeledInput(
                            label: "Pickup date",
                            controller: _controller,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabeledInput(
                            label: "Pickup time",
                            controller: _controller,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabeledInput(
                            label: "Merchant name",
                            controller: _controller,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          LabeledInput(
                            label: "Select warehouse",
                            controller: _controller,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Button(
                              primary: kPrimaryColor,
                              textColor: kWhite,
                              text: 'Select orders',
                              onPressed: () {
                                setState(() {
                                  _showTable = !_showTable;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
