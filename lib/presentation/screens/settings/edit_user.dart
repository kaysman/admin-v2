import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/screens/settings/settings.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    user = widget.userIdentity;
    settingsBloc = BlocProvider.of<SettingsBloc>(context);

    _firstNameController.text = user.firstName ?? "";
    _lastNameController.text = user.lastName ?? "";
    _emailController.text = user.emailAddress ?? "";
    _phoneController.text = user.phoneNumber ?? "";

    super.initState();
  }

  Widget _buildHeader(BuildContext context) {
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
              "Edit ${user.role?.name?.text} Information",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.start,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _editUserInfo(BuildContext context) {
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
              CircleAvatar(
                radius: 38,
                backgroundImage:
                    user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
              ),
              const SizedBox(width: 12),
              Button(
                text: "Edit",
                elevation: 0.0,
                textColor: Colors.black,
                onPressed: () {},
              ),
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
          const SizedBox(height: 24),
          LabeledInput(
            label: "Email",
            controller: _emailController,
          ),
          const SizedBox(height: 24),
          RowOfTwoChildren(
            child1: AppService.hasPermission(PermissionType.CHANGE_PASSWORD)
                ? LabeledInput(
                    label: "Password",
                    controller: _passwordController,
                  )
                : Center(
                    child: Text("No permission to change password"),
                  ),
            child2: LabeledInput(
              label: "Phone Number",
              controller: _phoneController,
            ),
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
              BlocBuilder<SettingsBloc, SettingsState>(
                bloc: settingsBloc,
                builder: (context, state) {
                  return Button(
                    text: "Done",
                    textColor: kWhite,
                    primary: kPrimaryColor,
                    isLoading: state.status == SettingsStatus.loading,
                    onPressed: () async {
                      var data = user.toJson();
                      data['firstName'] = _firstNameController.text;
                      data['lastName'] = _lastNameController.text;
                      data['emailAddress'] = _emailController.text;
                      data['phoneNumber'] = _phoneController.text;
                      print(data);
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
