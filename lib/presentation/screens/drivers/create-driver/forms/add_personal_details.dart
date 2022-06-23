import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:lng_adminapp/presentation/shared/spacings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';

class AddPersonalDetails extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final String? photoUrl;
  final GlobalKey<FormState> personalDetailsFormKey;
  final Function()? pickImagePressed;
  final bool isUpdating;
  final FilePickerResult? selectedImage;

  AddPersonalDetails({
    Key? key,
    this.photoUrl,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.personalDetailsFormKey,
    required this.selectedImage,
    required this.pickImagePressed,
    this.isUpdating = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 16.h);
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: this.personalDetailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    clipBehavior: Clip.none,
                    decoration: BoxDecoration(
                      color: kGrey3Color,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    padding: EdgeInsets.all(2.w),
                    child: this.selectedImage != null
                        ? ClipOval(
                            child: Image.memory(
                              this.selectedImage!.files.first.bytes!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : isUpdating && this.photoUrl != null
                            ? Image.network(
                                this.photoUrl!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.person,
                                size: 30.w,
                                color: kPrimaryColor,
                              ),
                  ),
                  Spacings.SMALL_HORIZONTAL,
                  InkWell(
                    onTap: this.pickImagePressed,
                    child: Text(
                      isUpdating && selectedImage != null
                          ? 'Edit photo'
                          : 'Add a photo',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                ],
              ),
              space,
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'First Name',
                  hintText: 'First Name',
                  controller: this.firstNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: emptyField,
                ),
                child2: LabeledInput(
                  label: 'Last Name',
                  hintText: 'Last Name',
                  controller: this.lastNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              if (!isUpdating) ...[
                space,
                LabeledInput(
                  label: 'Email',
                  hintText: 'Email',
                  controller: this.emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  isEnabled: !isUpdating,
                  validator: validateEmail,
                ),
              ],
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Phone Number',
                  hintText: 'e.g. 95832153',
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: this.phoneController,
                  validator: emptyField,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                child2: !isUpdating
                    ? LabeledInput(
                        label: 'Password',
                        hintText: 'Enter Password',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: this.passwordController,
                        validator: validatePassword,
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
