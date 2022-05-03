import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Form(
        key: _formKey,
        child: Row(
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
                    color: Colors.white,
                  ),
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
                          controller: _firstNameController,
                        ),
                        child2: LabeledInput(
                          label: "Last name",
                          controller: _lastNameController,
                        ),
                      ),
                      SizedBox(height: 24.sp),
                      LabeledInput(
                        label: "Email",
                        controller: _emailController,
                      ),
                      SizedBox(height: 24.sp),
                      RowOfTwoChildren(
                        child1: LabeledInput(
                          label: "Password",
                          controller: _passwordController,
                        ),
                        child2: LabeledInput(
                          label: "Phone number",
                          controller: _phoneController,
                        ),
                      ),
                      SizedBox(height: 24.sp),
                      Text("Assigned role"),
                      SizedBox(height: 8),
                      BlocBuilder<RoleBloc, RoleState>(
                          builder: (context, state) {
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
                            onChanged: (v) {
                              setState(() {
                                assignedRole = v;
                              });
                            },
                            items: state.roles!.items
                                ?.map((e) => DropdownMenuItem<Role>(
                                      value: e,
                                      child: Text(e.name ?? ''),
                                    ))
                                .toList(),
                          ),
                        );
                      }),
                      SizedBox(height: 24.sp),
                      BlocConsumer<SubuserBloc, SubuserState>(
                          listenWhen: (state1, state2) =>
                              state1.createUserStatus !=
                              state2.createUserStatus,
                          listener: (context, state) {
                            if (state.createUserStatus ==
                                CreateRoleStatus.success) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  IndexScreen.routeName, (route) => false);
                            }
                          },
                          builder: (context, state) {
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
            )
          ],
        ),
      ),
    );
  }

  onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      if (assignedRole == null) return;

      CreateUserWithinSystem user = CreateUserWithinSystem(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        emailAddress: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneController.text,
        roleId: assignedRole!.id!,
      );

      await subUserBloc.createSubuser(user);
    }
  }
}
