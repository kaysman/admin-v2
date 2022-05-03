import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
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
          RowOfTwoChildren(
            child1: LabeledInput(
              label: "Email",
              controller: _emailController,
            ),
            child2: LabeledInput(
              label: "Phone Number",
              controller: _phoneController,
            ),
          ),
          const SizedBox(height: 24),
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

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
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
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Ali Bg"),
          const SizedBox(height: 24.0),
          LabeledInput(
            label: "Old password",
            controller: oldController,
          ),
          const SizedBox(height: 16.0),
          LabeledInput(
            label: "New password",
            controller: newController,
          ),
          const SizedBox(height: 16.0),
          BlocConsumer<SettingsBloc, SettingsState>(
            listenWhen: (state1, state2) =>
                state1.changepasswordStatus != state2.changepasswordStatus,
            listener: (context, state) {
              if (state.changepasswordStatus == ChangepasswordStatus.success) {
                showSnackBar(context, Text("Password changed"));
              }
            },
            builder: (context, state) {
              return Button(
                textColor: kWhite,
                primary: kPrimaryColor,
                isLoading:
                    state.changepasswordStatus == ChangepasswordStatus.loading,
                text: "Ok",
                onPressed: () async {
                  await settingsBloc.changePassword(
                    oldController.text,
                    newController.text,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
