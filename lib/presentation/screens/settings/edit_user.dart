import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/presentation/screens/settings/settings.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class EditUserInfo extends StatefulWidget {
  static const String routeName = 'edit-user-info';

  const EditUserInfo({Key? key, required this.userIdentity}) : super(key: key);

  final User userIdentity;

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  late User user;
  late SettingsBloc settingsBloc;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  FilePickerResult? _selectedImage;

  @override
  void initState() {
    user = widget.userIdentity;
    settingsBloc = BlocProvider.of<SettingsBloc>(context);

    _firstNameController.text = user.firstName ?? "";
    _lastNameController.text = user.lastName ?? "";
    _phoneController.text = user.phoneNumber ?? "";

    super.initState();
  }

  Future<void> pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() => _selectedImage = result);
    } on PlatformException catch (e) {
      print('failed to pick image $e');
    }
  }

  _buildHeader(BuildContext context) {
    return Container(
      color: kGreyBackground,
      padding: const EdgeInsets.only(
        left: Spacings.kSpaceLittleBig,
        top: 29,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlatBackButton(),
          SizedBox(height: 32),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Edit ${user.role?.name} Information",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
          ]),
        ],
      ),
    );
  }

  _editUserInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // <---
        children: [
          Text(
            "User Information",
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                child: _selectedImage != null
                    ? ClipOval(
                        child: Image.memory(
                          _selectedImage!.files.first.bytes!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : user.photoUrl != null
                        ? Image.network(
                            user.photoUrl!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 30.w,
                            color: kPrimaryColor,
                          ),
              ),
              const SizedBox(width: 12),
              Spacings.SMALL_HORIZONTAL,
              InkWell(
                onTap: this.pickImage,
                child: Text(
                  user.photoUrl == null ? 'Add photo' : 'Edit photo',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "First Name",
              controller: _firstNameController,
            ),
            child2: LabeledInput(
              label: "Last Name",
              controller: _lastNameController,
            ),
          ),
          LabeledInput(
            label: "Phone Number",
            controller: _phoneController,
            hintText: "e.g. 95832153",
          ),
          TextButton(
            onPressed: () {
              showWhiteDialog(context, ChangePasswordDialog());
            },
            child: Text("Change password"),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.button,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: kPrimaryColor,
                    side: BorderSide(color: kPrimaryColor)),
              ),
              const SizedBox(width: 16),
              BlocConsumer<SettingsBloc, SettingsState>(
                bloc: settingsBloc,
                listener: (context, state) {
                  if (state.status == SettingsStatus.success) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, IndexScreen.routeName, (route) => false);
                  }
                },
                builder: (context, state) {
                  return Button(
                    text: "Done",
                    textColor: kWhite,
                    primary: kPrimaryColor,
                    isLoading: state.status == SettingsStatus.loading,
                    onPressed: () async {
                      String? base64String;
                      if (_selectedImage != null) {
                        base64String =
                            '${base64.encode(_selectedImage!.files[0].bytes as List<int>)}-ext-${_selectedImage!.files[0].extension}';
                        ;
                      }
                      var data = user.toJson();
                      data['id'] = widget.userIdentity.id;
                      data['firstName'] = _firstNameController.text;
                      data['lastName'] = _lastNameController.text;
                      data['phoneNumber'] = _phoneController.text;
                      data['photoUrl'] = base64String;
                      await settingsBloc.updateUser(data);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Column(
        children: [
          _buildHeader(context),
          Container(
            color: kGreyBackground,
            padding:
                const EdgeInsets.only(left: Spacings.kSpaceLittleBig, top: 29),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 0.48.sw,
                  child: _editUserInfo(context),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 45,
                        color: const Color(0xff000000).withOpacity(0.1),
                      ),
                    ],
                    border: Border.all(color: kWhite),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final oldController = TextEditingController();
  final newController = TextEditingController();

  late SettingsBloc settingsBloc;

  @override
  void initState() {
    settingsBloc = BlocProvider.of<SettingsBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    oldController.dispose();
    newController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.3.sw,
      padding: EdgeInsets.all(Spacings.kSpaceLittleBig),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Change password",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 24.0),
            LabeledInput(
              label: "Old password",
              controller: oldController,
              validator: validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            LabeledInput(
              label: "New password",
              controller: newController,
              validator: validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16.0),
            BlocConsumer<SettingsBloc, SettingsState>(
              listenWhen: (state1, state2) =>
                  state1.changepasswordStatus != state2.changepasswordStatus,
              listener: (context, state) {
                if (state.changepasswordStatus ==
                    ChangepasswordStatus.success) {
                  showSnackBar(context, Text("Password changed"));
                }
              },
              builder: (context, state) {
                return Button(
                  textColor: kWhite,
                  primary: kPrimaryColor,
                  isLoading: state.changepasswordStatus ==
                      ChangepasswordStatus.loading,
                  text: "Ok",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await settingsBloc.changePassword(
                        oldController.text,
                        newController.text,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
