import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/role/create-role.model.dart';
import 'package:lng_adminapp/data/models/role/module.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/permission_bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role.bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/shared.dart';
import 'role_permission.dart';

class AddRoleScreen extends StatefulWidget {
  static const String routeName = 'add-role';
  const AddRoleScreen({Key? key}) : super(key: key);

  @override
  _AddRoleScreenState createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  List<Module> modules = <Module>[];
  GlobalKey<FormState> addRoleKey = GlobalKey<FormState>();
  TextEditingController roleNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late RoleBloc roleBloc;
  late PermissionBloc permissionBloc;
  List<String> permissionIds = <String>[];
  Role? role;

  @override
  void initState() {
    modules = RoleAndPermissionsService.modules.value ?? [];
    roleBloc = BlocProvider.of<RoleBloc>(context);
    permissionBloc = BlocProvider.of<PermissionBloc>(context);
    checkIfUserIsUpdating();
    super.initState();
  }

  @override
  void dispose() {
    roleNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void checkIfUserIsUpdating() {
    if (RoleAndPermissionsService.selectedRole.value != null) {
      role = RoleAndPermissionsService.selectedRole.value;
      roleNameController.text = role?.name ?? "";
      descriptionController.text = role?.description ?? '';
      permissionIds =
          role?.permissions?.map((permission) => permission.id!).toList() ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: FlatBackButton(),
          ),
          Container(
            // margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              role == null ? 'Add a New Role' : 'Update Role',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: kText1Color,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
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
                child: Form(
                  key: addRoleKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Role Information',
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(
                        height: 24,
                      ),
                      LabeledInput(
                        label: 'Role Name',
                        controller: roleNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return emptyField(value);
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      LabeledInput(
                        label: 'Description',
                        controller: descriptionController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return emptyField(value);
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        'Role Permissions',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<PermissionBloc, PermissionState>(
                        bloc: permissionBloc,
                        builder: (context, state) {
                          var isStateDataNull = state.listPermissionsStatus ==
                                  ListPermissionsStatus.idle &&
                              state.permissions == null;

                          List<Widget> permissionTiles = [];
                          if (state.permissions?.data != null) {
                            state.permissions?.data!
                                .forEach((key, permissions) {
                              permissionTiles.add(
                                RolePermissionExpandableTile(
                                  title: key,
                                  permissions: List.generate(permissions.length,
                                      (index) {
                                    var itemID = permissions[index].id!;
                                    return PermissionToggle(
                                      permission: permissions[index],
                                      isToggled: permissionIds.contains(itemID),
                                      onValueChanged: (value) {
                                        setState(() {
                                          if (value) {
                                            permissionIds.add(itemID);
                                          } else {
                                            permissionIds.remove(itemID);
                                          }
                                        });
                                      },
                                    );
                                  }),
                                ),
                              );
                            });
                          }

                          if (state.listPermissionsStatus ==
                              ListPermissionsStatus.loading) {
                            return Text("Fetching permissions");
                          } else if (state.listPermissionsStatus ==
                              ListPermissionsStatus.error) {
                            return TryAgainButton(
                              tryAgain: permissionBloc.loadPermissions,
                            );
                          } else if (isStateDataNull) {
                            return Text("There is no permissions");
                          }

                          return Column(children: permissionTiles);
                        },
                      ),
                      BlocBuilder<RoleBloc, RoleState>(
                        bloc: roleBloc,
                        builder: (context, state) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Button(
                              text: role == null ? 'Save' : 'Update',
                              borderColor: kBlack,
                              hasBorder: true,
                              isLoading: state.createRoleStatus ==
                                  CreateRoleStatus.loading,
                              onPressed: () async {
                                await submitForm(role != null, role);
                              },
                              textColor: kBlack,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submitForm(bool isUpdating, Role? role) async {
    final isValid = addRoleKey.currentState!.validate();

    if (isValid) {
      CreateRole _role = CreateRole(
        id: isUpdating ? role?.id : null,
        name: roleNameController.text,
        description: descriptionController.text,
        permissionIds: permissionIds,
      );

      await roleBloc.createRole(_role, context, isUpdating, role);
    }
  }
}
