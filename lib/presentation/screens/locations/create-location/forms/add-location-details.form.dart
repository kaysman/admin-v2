import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';
import 'package:lng_adminapp/shared.dart';

class AddLocationDetails extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController sizeController;
  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController postalController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final GlobalKey<FormState> locationDetailsFormKey;
  final WarehouseType? selectedType;
  final ValueChanged<WarehouseType?> onTypeChanged;
  final bool isUpdating;

  AddLocationDetails({
    Key? key,
    required this.locationDetailsFormKey,
    this.isUpdating = false,
    required this.nameController,
    required this.typeController,
    required this.sizeController,
    required this.address1Controller,
    required this.address2Controller,
    required this.postalController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    this.selectedType,
    required this.onTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 12);
    return StatefulBuilder(builder: (context, _setState) {
      return Padding(
        padding: EdgeInsets.all(24.w),
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
                  controller: this.nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: emptyField,
                ),
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Address Line 1',
                    hintText: 'Address Line 1',
                    controller: this.address1Controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: emptyField,
                  ),
                  child2: LabeledInput(
                    label: 'Address Line 2',
                    hintText: 'Address Line 2',
                    controller: this.address2Controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Size',
                    hintText: 'Size',
                    controller: this.sizeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: emptyField,
                  ),
                  child2: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location type",
                          style: Theme.of(context).textTheme.caption),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            width: 0.0,
                            color: kGrey1Color,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<WarehouseType>(
                            borderRadius: BorderRadius.circular(2),
                            elevation: 1,
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                "Type",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            // decoration: InputDecoration(hintText: "Type"),
                            value: selectedType,
                            onChanged: onTypeChanged,
                            // validator: (v) =>
                            //     v == null ? 'This field is required' : null,
                            items: WarehouseType.values.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Text(
                                    e.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Postal Code',
                    hintText: 'Postal Code',
                    controller: this.postalController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  child2: LabeledInput(
                    label: 'City',
                    hintText: 'City',
                    controller: this.cityController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'State',
                    hintText: 'State',
                    controller: this.stateController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  child2: LabeledInput(
                    label: 'Country',
                    hintText: 'Country',
                    controller: this.countryController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
