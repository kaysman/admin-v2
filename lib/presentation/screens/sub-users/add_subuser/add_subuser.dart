import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-within-system.model.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role.bloc.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/shared.dart';

import '../subuser_bloc.dart';

class AddSubuserScreen extends StatefulWidget {
  static const String routeName = "add-subuser";
  const AddSubuserScreen({Key? key}) : super(key: key);

  @override
  State<AddSubuserScreen> createState() => _AddSubuserScreenState();
}

class _AddSubuserScreenState extends State<AddSubuserScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  FilePickerResult? selectedImage;
  Role? assignedRole;

  late RoleBloc roleBloc;
  late SubuserBloc subUserBloc;

  @override
  void initState() {
    roleBloc = BlocProvider.of<RoleBloc>(context);
    subUserBloc = BlocProvider.of<SubuserBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() => selectedImage = result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: LngPage(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlatBackButton(),
              SizedBox(height: 32.h),
              Container(
                child: Text(
                  "Add a new sub-user",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: kText1Color,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: 0.35.sw,
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
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: EdgeInsets.all(
                            2.w,
                          ),
                          child: this.selectedImage != null
                              ? ClipOval(
                                  child: Image.memory(
                                    this.selectedImage!.files.first.bytes!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 30.w,
                                  color: kPrimaryColor,
                                ),
                        ),
                        Spacings.SMALL_HORIZONTAL,
                        InkWell(
                          onTap: pickImage,
                          child: Text(
                            'Add a photo',
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12),
                    RowOfTwoChildren(
                      child1: LabeledInput(
                        label: "First name",
                        controller: _firstNameController,
                        validator: emptyField,
                      ),
                      child2: LabeledInput(
                        label: "Last name",
                        controller: _lastNameController,
                        validator: emptyField,
                      ),
                    ),
                    LabeledInput(
                      label: "Email",
                      controller: _emailController,
                      validator: validateEmail,
                    ),
                    RowOfTwoChildren(
                      child1: LabeledInput(
                        label: "Password",
                        controller: _passwordController,
                        validator: validatePassword,
                      ),
                      child2: LabeledInput(
                        label: "Phone number",
                        controller: _phoneController,
                        validator: emptyField,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Text("Assigned role",
                        style: Theme.of(context).textTheme.caption),
                    SizedBox(height: 8),
                    BlocBuilder<RoleBloc, RoleState>(builder: (context, state) {
                      var isStateDataNull =
                          state.roleStatus == RoleStatus.idle &&
                              state.roles == null;

                      if (state.roleStatus == RoleStatus.loading) {
                        return Text("Fetching permissions");
                      } else if (state.roleStatus == RoleStatus.error) {
                        return TryAgainButton(
                          tryAgain: roleBloc.loadRoles(),
                        );
                      } else if (isStateDataNull) {
                        return Text("There is no permissions");
                      }

                      return DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<Role>(
                          value: assignedRole,
                          validator: (Role? v) =>
                              v == null ? "Field required" : null,
                          onChanged: (v) {
                            setState(() {
                              assignedRole = v;
                            });
                          },
                          decoration: InputDecoration(
                            suffixIcon: assignedRole != null
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        assignedRole = null;
                                      });
                                    },
                                    child: Icon(Icons.clear),
                                  )
                                : null,
                          ),
                          items: state.roles!.items
                              ?.map((e) => DropdownMenuItem<Role>(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    }),
                    SizedBox(height: 16),
                    BlocConsumer<SubuserBloc, SubuserState>(
                        listener: (context, state) {
                      if (state.createUserStatus ==
                          CreateSubuserStatus.success) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, IndexScreen.routeName, (route) => false);
                      }
                    }, builder: (context, state) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Button(
                          textColor: kWhite,
                          primary: kPrimaryColor,
                          text: 'Save',
                          isLoading: state.createUserStatus ==
                              CreateSubuserStatus.loading,
                          onPressed: onSavePressed,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      String? base64String;
      if (selectedImage != null) {
        base64String =
            '${base64.encode(selectedImage!.files[0].bytes as List<int>)}-ext-${selectedImage!.files[0].extension}';
      }

      CreateUserWithinSystem user = CreateUserWithinSystem(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
        photoUrl: base64String,
        roleId: assignedRole!.id!,
        typeOfUserCreated: SpecificTypeOfUser.NOT_APPLICABLE,
      );

      await subUserBloc.createSubuser(user);
    }
  }
}
