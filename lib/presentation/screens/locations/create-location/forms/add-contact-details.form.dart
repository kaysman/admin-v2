import 'package:flutter/material.dart';
import 'package:lng_adminapp/presentation/shared/components/labeled_input.dart';
import 'package:lng_adminapp/presentation/shared/components/row_2_children.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/shared/validators.dart';

class AddContactDetails extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final GlobalKey<FormState>? contactDetailsFormKey;

  AddContactDetails({
    Key? key,
    @required this.nameController,
    @required this.emailController,
    @required this.phoneController,
    @required this.contactDetailsFormKey,
  }) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<AddContactDetails> {
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
      padding: EdgeInsets.all(3.w),
      child: Form(
        key: widget.contactDetailsFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              LabeledInput(
                label: 'Full name',
                hintText: 'Full name',
                controller: widget.nameController!,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) {
                //   return emptyField(value);
                // },
              ),
              space,
              LabeledInput(
                label: 'Email address',
                hintText: 'Email address',
                controller: widget.emailController!,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // validator: (value) {
                //   return emptyField(value);
                // },
              ),
              space,
              RowOfTwoChildren(
                child1: LabeledInput(
                  label: 'Phone number',
                  hintText: 'Phone number',
                  controller: widget.phoneController!,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (value) {
                  //   return emptyField(value);
                  // },
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
