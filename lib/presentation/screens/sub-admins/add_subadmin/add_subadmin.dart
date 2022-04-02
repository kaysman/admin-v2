import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/shared.dart';

class AddSubadminScreen extends StatefulWidget {
  static const String routeName = "add-subadmin";
  const AddSubadminScreen({Key? key}) : super(key: key);

  @override
  State<AddSubadminScreen> createState() => _AddSubadminScreenState();
}

class _AddSubadminScreenState extends State<AddSubadminScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatBackButton(),
                    SizedBox(height: 32.sp),
                    Text(
                      "Add a new Sub-admin",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
              Container(
                width: 0.35.sw,
                height: 539.sp,
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: kGrey3Color,
                            child: Center(
                              child: Icon(
                                Icons.person_outline_outlined,
                                color: kGrey1Color,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            child: Text("Add photo"),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.sp),
                      RowOfTwoChildren(
                        child1: LabeledInput(
                          label: "First name",
                          controller: _nameController,
                        ),
                        child2: LabeledInput(
                          label: "Last name",
                          controller: _nameController,
                        ),
                      ),
                      SizedBox(height: 24.sp),
                      LabeledInput(
                        label: "Email",
                        controller: _nameController,
                      ),
                      SizedBox(height: 24.sp),
                      RowOfTwoChildren(
                        child1: LabeledInput(
                          label: "Password",
                          controller: _nameController,
                        ),
                        child2: LabeledInput(
                          label: "Phone number",
                          controller: _nameController,
                        ),
                      ),
                      SizedBox(height: 24.sp),
                      // RadioDropdown(
                      //   items: [],
                      //   onSelected: (v) {},
                      // ),
                      SizedBox(height: 24.sp),
                      Align(
                        alignment: Alignment.topRight,
                        child: Button(
                          text: 'Save',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
