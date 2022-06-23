import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';
import 'package:lng_adminapp/shared.dart';

class AddVehicleDetails extends StatelessWidget {
  final TextEditingController? modelController;
  final TextEditingController? modelYearController;
  final TextEditingController? licenseController;
  final TextEditingController? colorController;
  final GlobalKey<FormState>? vehicleDetailsFormKey;

  final VehicleType? selectedVehicleType;
  final ValueChanged<VehicleType?>? vehicleTypeChanged;

  AddVehicleDetails({
    Key? key,
    required this.colorController,
    required this.modelController,
    required this.modelYearController,
    required this.licenseController,
    required this.vehicleDetailsFormKey,
    required this.selectedVehicleType,
    this.vehicleTypeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);

    return StatefulBuilder(
      builder: (context, _setState) {
        return Container(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: this.vehicleDetailsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                space,
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'Vehicle Model',
                    hintText: 'Vehicle Model',
                    controller: this.modelController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                  child2: LabeledInput(
                    label: 'Model Year',
                    hintText: 'Model Year',
                    controller: this.modelYearController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                ),
                space,
                RowOfTwoChildren(
                  child1: LabeledInput(
                    label: 'License No',
                    hintText: 'License No',
                    controller: this.licenseController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                  child2: LabeledInput(
                    label: 'Vehicle Colour',
                    hintText: 'Vehicle Colour',
                    controller: this.colorController!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return emptyField(value);
                    },
                  ),
                ),
                space,
                Text("Vehicle Type",
                    style: Theme.of(context).textTheme.caption),
                SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: 1.0,
                      color: kGrey3Color,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<VehicleType>(
                      value: selectedVehicleType,
                      onChanged: vehicleTypeChanged,
                      borderRadius: BorderRadius.circular(6),
                      elevation: 1,
                      isExpanded: true,
                      items: VehicleType.values
                          .map((e) => DropdownMenuItem(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Text(e.name,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ),
                                value: e,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
