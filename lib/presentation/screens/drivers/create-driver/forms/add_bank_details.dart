import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';

class AddBankDetails extends StatefulWidget {
  TextEditingController? address1Controller;
  TextEditingController? address2Controller;
  TextEditingController? postalController;
  TextEditingController? cityController;
  TextEditingController? stateController;
  TextEditingController? countryController;
  TextEditingController? bankAccountController;
  TextEditingController? noteController;
  GlobalKey<FormState>? bankDetailsFormKey;

  AddBankDetails({
    Key? key,
    required this.address1Controller,
    required this.address2Controller,
    required this.postalController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.bankAccountController,
    required this.noteController,
    required this.bankDetailsFormKey,
  }) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<AddBankDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(
      height: 16.h,
    );
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: widget.bankDetailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Address Line 1',
                  hintText: 'Address Line 1',
                  controller: widget.address1Controller!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                child2: LabeledInput(
                  label: 'Address Line 2',
                  hintText: 'Address Line 2',
                  controller: widget.address2Controller!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Postal Code',
                  hintText: 'Postal Code',
                  controller: widget.postalController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                child2: LabeledInput(
                  label: 'City',
                  hintText: 'City',
                  controller: widget.cityController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'State',
                  hintText: 'State',
                  controller: widget.stateController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                child2: LabeledInput(
                  label: 'Country',
                  hintText: 'Country',
                  controller: widget.countryController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
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
