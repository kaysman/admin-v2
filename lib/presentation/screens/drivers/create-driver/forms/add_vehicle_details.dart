import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/presentation/shared/components/button.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';

class AddVehicleDetails extends StatelessWidget {
  final TextEditingController? modelController;
  final TextEditingController? modelYearController;
  final TextEditingController? licenseController;
  final TextEditingController? colorController;
  final GlobalKey<FormState>? vehicleDetailsFormKey;
  String? selectedVehicleType;
  AddVehicleDetails({
    Key? key,
    @required this.colorController,
    @required this.modelController,
    @required this.modelYearController,
    @required this.licenseController,
    @required this.vehicleDetailsFormKey,
    @required this.selectedVehicleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);
    List<String> _vehicleTypes = [
      'WALKER',
      'CYCLIST',
      'MOTORBIKE',
      'CAR',
      'VAN',
      'FOOTER_14',
      'FOOTER_24',
      'OTHER'
    ];

    return StatefulBuilder(
      builder: (context, _setState) {
        return Padding(
          padding: EdgeInsets.all(3.w),
          child: Form(
            key: this.vehicleDetailsFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // RowOfTwoChildren(
                //   child1: LabeledRadioDropdown(
                //     label: "Vehicle Type",
                //     value: selectedVehicleType,
                //     onSelected: (String v) => _setState(() {
                //       selectedVehicleType = v;
                //     }),
                //     items: _vehicleTypes,
                //   ),
                //   child2: SizedBox(),
                // ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
