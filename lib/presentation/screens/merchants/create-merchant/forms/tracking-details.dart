import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class AddTrackingDetails extends StatelessWidget {
  final TextEditingController? trackingPhoneNumberController;
  final TextEditingController? trackingEmailAddressController;
  final GlobalKey<FormState>? trackingDetailsFormKey;

  const AddTrackingDetails({
    Key? key,
    @required this.trackingEmailAddressController,
    @required this.trackingPhoneNumberController,
    @required this.trackingDetailsFormKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);

    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Form(
        key: this.trackingDetailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Phone number',
                  controller: this.trackingPhoneNumberController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                child2: LabeledInput(
                  label: 'Email Address',
                  controller: this.trackingEmailAddressController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
