import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class AddContactDetails extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> contactDetailsFormKey;

  AddContactDetails({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.contactDetailsFormKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(
      height: 16.h,
    );
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: contactDetailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LabeledInput(
                label: 'Full name',
                hintText: 'Full name',
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: emptyField,
              ),
              space,
              LabeledInput(
                label: 'Email address',
                hintText: 'Email address',
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateEmail,
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Phone number',
                  hintText: 'Phone number',
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: emptyField,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                child2: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
