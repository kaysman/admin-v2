import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:lng_adminapp/presentation/shared/spacings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';

class AddLocationDetails extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController? typeController;
  final TextEditingController? sizeController;
  final TextEditingController? address1Controller;
  final TextEditingController? address2Controller;
  final TextEditingController? postalController;
  final TextEditingController? cityController;
  final TextEditingController? stateController;
  final TextEditingController? countryController;
  final GlobalKey<FormState>? locationDetailsFormKey;
  String? selectedType;

  final bool isUpdating;

  AddLocationDetails({
    Key? key,
    @required this.locationDetailsFormKey,
    this.isUpdating = false,
    @required this.nameController,
    @required this.typeController,
    @required this.sizeController,
    @required this.address1Controller,
    @required this.address2Controller,
    @required this.postalController,
    @required this.cityController,
    @required this.stateController,
    @required this.countryController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _locationTypes = ['FIXED', 'FLEXIBLE'];
    Widget space = SizedBox(height: 16.h);
    return StatefulBuilder(builder: (context, _setState) {
      return Padding(
        padding: EdgeInsets.all(3.w),
        child: Form(
          key: this.locationDetailsFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LabeledInput(
                  label: 'Location name',
                  hintText: 'Location name',
                  controller: this.nameController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                space,
                // RowOfTwoChildren(
                //   child1: LabeledRadioDropdown(
                //     label: "Location Type",
                //     value: selectedType,
                //     onSelected: (String v) => _setState(() {
                //       selectedType = v;
                //     }),
                //     items: _locationTypes,
                //   ),
                //   child2: LabeledInput(
                //     label: 'Size',
                //     hintText: 'Size',
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     controller: this.sizeController!,
                //     validator: (value) {
                //       return emptyField(value);
                //     },
                //   ),
                // ),
                space,
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Address Line 1',
                    hintText: 'Address Line 1',
                    controller: this.address1Controller!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                  child2: LabeledInput(
                    label: 'Address Line 2',
                    hintText: 'Address Line 2',
                    controller: this.address2Controller!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                ),
                space,
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Postal Code',
                    hintText: 'Postal Code',
                    controller: this.postalController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                  child2: LabeledInput(
                    label: 'City',
                    hintText: 'City',
                    controller: this.cityController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                ),
                space,
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'State',
                    hintText: 'State',
                    controller: this.stateController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                  child2: LabeledInput(
                    label: 'Country',
                    hintText: 'Country',
                    controller: this.countryController!,
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
    });
  }
}
