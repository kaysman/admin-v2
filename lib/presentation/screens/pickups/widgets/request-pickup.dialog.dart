import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestPickupDialog extends StatefulWidget {
  RequestPickupDialog({Key? key}) : super(key: key);

  @override
  _RequestPickupDialogState createState() => _RequestPickupDialogState();
}

class _RequestPickupDialogState extends State<RequestPickupDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 300.w,
      height: 300.w,
    );
  }
}
