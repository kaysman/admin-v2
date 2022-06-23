import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/shared.dart';

class AddCompanyDetails extends StatelessWidget {
  final TextEditingController companyNameController;
  final TextEditingController addressLineOneController;
  final TextEditingController addressLineTwoController;
  final TextEditingController postalCodeController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;
  final TextEditingController vatController;
  final TextEditingController contactNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailAddressController;
  final GlobalKey<FormState> companyDetailsFormKey;

  const AddCompanyDetails({
    Key? key,
    required this.companyNameController,
    required this.addressLineOneController,
    required this.addressLineTwoController,
    required this.postalCodeController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
    required this.vatController,
    required this.contactNameController,
    required this.phoneNumberController,
    required this.companyDetailsFormKey,
    required this.emailAddressController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: this.companyDetailsFormKey,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            shrinkWrap: true,
            //crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              LabeledInput(
                label: 'Company name',
                controller: this.companyNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return emptyField(value);
                },
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Address line 1',
                  controller: this.addressLineOneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                child2: LabeledInput(
                  label: 'Address line 2',
                  controller: this.addressLineTwoController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Postal code',
                  controller: this.postalCodeController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                child2: LabeledInput(
                  label: 'City',
                  controller: this.cityController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'State',
                  controller: this.stateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                child2: LabeledInput(
                  label: 'Country',
                  controller: this.countryController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'VAT/GST ID',
                  controller: this.vatController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                child2: SizedBox(),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Main Contact Details',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              LabeledInput(
                label: 'Full name',
                controller: this.contactNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return emptyField(value);
                },
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Phone number',
                  controller: this.phoneNumberController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return emptyField(value);
                  },
                ),
                child2: LabeledInput(
                  label: 'Email address',
                  controller: this.emailAddressController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return validateEmail(value);
                  },
                ),
              ),
            ],
          ),
        ),

        // child: SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       LabeledInput(
        //         label: 'Company name',
        //         controller: this.companyNameController!,
        //         autovalidateMode: AutovalidateMode.onUserInteraction,
        //         validator: (value) {
        //           return emptyField(value);
        //         },
        //       ),
        //       space,
        //       RowOfTwoChildren(
        //         child1: LabeledInput(
        //           label: 'Address line 1',
        //           controller: this.addressLineOneController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return emptyField(value);
        //           },
        //         ),
        //         child2: LabeledInput(
        //           label: 'Address line 2',
        //           controller: this.addressLineTwoController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //         ),
        //       ),
        //       space,
        //       RowOfTwoChildren(
        //         child1: LabeledInput(
        //           label: 'Postal code',
        //           controller: this.postalCodeController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return emptyField(value);
        //           },
        //         ),
        //         child2: LabeledInput(
        //           label: 'City',
        //           controller: this.cityController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return emptyField(value);
        //           },
        //         ),
        //       ),
        //       space,
        //       RowOfTwoChildren(
        //         child1: LabeledInput(
        //           label: 'State',
        //           controller: this.stateController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //         ),
        //         child2: LabeledInput(
        //           label: 'Country',
        //           controller: this.countryController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return emptyField(value);
        //           },
        //         ),
        //       ),
        //       space,
        //       RowOfTwoChildren(
        //         child1: LabeledInput(
        //           label: 'VAT/GST ID',
        //           controller: this.vatController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //         ),
        //         child2: SizedBox(),
        //       ),
        //       SizedBox(
        //         height: 24.h,
        //       ),
        //       Text(
        //         'Main Contact Details',
        //         style: GoogleFonts.inter(
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //       SizedBox(
        //         height: 24.h,
        //       ),
        //       LabeledInput(
        //         label: 'Full name',
        //         controller: this.contactNameController!,
        //         autovalidateMode: AutovalidateMode.onUserInteraction,
        //         validator: (value) {
        //           return emptyField(value);
        //         },
        //       ),
        //       space,
        //       RowOfTwoChildren(
        //         child1: LabeledInput(
        //           label: 'Phone number',
        //           controller: this.phoneNumberController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return emptyField(value);
        //           },
        //         ),
        //         child2: LabeledInput(
        //           label: 'Email address',
        //           controller: this.emailAddressController!,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           validator: (value) {
        //             return validateEmail(value);
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
