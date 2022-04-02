import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/role/create-role.model.dart';
import 'package:lng_adminapp/data/models/role/module.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
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
  List<String> permissionIds = <String>[];
  Role? role;

  @override
  void initState() {
    modules = RoleService.modules.value ?? [];
    roleBloc = BlocProvider.of<RoleBloc>(context);
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
    if (RoleService.selectedRole.value != null) {
      role = RoleService.selectedRole.value;
      roleNameController.text = role?.name?.text ?? "";
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
              alignment: Alignment.topLeft,
              width: 0.35.sw,
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
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      // if (role == null) ...[
                      ...List.generate(modules.length, (index) {
                        var module = modules[index];
                        return RolePermission(
                          title: module.name ?? "",
                          permissions: List.generate(module.permissions!.length,
                              (index) {
                            var permission = module.permissions![index];
                            return PermissionToggle(
                              permission: permission,
                              isToggled: role == null
                                  ? false
                                  : RoleService.hasPermission(
                                      role!.permissions!, permission.id!),
                              onValueChanged: (value) {
                                if (value.status == true) {
                                  permissionIds.add(value.id!);
                                } else {
                                  permissionIds.remove(value.id!);
                                }
                                // continue from here
                                print(permissionIds.length);
                              },
                            );
                          }),
                        );
                      }),
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

  submitForm(bool isUpdating, Role? role) async {
    final isValid = addRoleKey.currentState!.validate();

    if (isValid) {
      CreateRole _role = CreateRole(
        id: role?.id ?? null,
        name: getRoleType(roleNameController.text),
        description: descriptionController.text,
        permissionIds: permissionIds,
      );

      await roleBloc.createRole(_role, context, isUpdating, role);
    }
  }
}
