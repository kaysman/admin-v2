import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.view.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/add_role_screen/add_role_screen.dart';
import 'package:lng_adminapp/presentation/shared/components/layouts/view-content.layout.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';
import 'permission_details.dart';
import 'role_details.dart';

class RoleDetailsScreen extends StatefulWidget {
  static const String routeName = 'role-details';
  const RoleDetailsScreen({Key? key}) : super(key: key);

  @override
  _RoleDetailsScreenState createState() => _RoleDetailsScreenState();
}

class _RoleDetailsScreenState extends State<RoleDetailsScreen> {
  Role? role;
  deleteFunction(String? id) {
    showWhiteDialog(
      context,
      DeleteDialog(
        title: 'Delete Role',
        message: 'Are you ready to delete',
        type: DialogType.DELETE,
        module: ModuleType.ROLE,
        id: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (RoleAndPermissionsService.selectedRole.value != null) {
      role = RoleAndPermissionsService.selectedRole.value;
    } else {
      print('nope nope nope');
    }
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: ValueListenableBuilder(
        valueListenable: RoleAndPermissionsService.selectedRole,
        builder: (BuildContext context, Role? v, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: FlatBackButton(),
              ),
              ViewContentLayout(
                color: kWhite,
                title: 'Role Details',
                height: 700.h,
                content: [
                  RoleDetails(
                    id: replaceStringWithDash(v?.id),
                    name: replaceStringWithDash(v?.name),
                    description: replaceStringWithDash(v?.description),
                    creationTime: replaceStringWithDash(v?.createdAt),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  // PermissionDetails(
                  //   permissions:
                  //       role!.permissions?.map((e) => e.name!).toList(),
                  // ),
                ],
                footer: Row(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        if (AppService.hasPermission(
                            PermissionType.DELETE_ROLE))
                          Button(
                            text: 'Delete',
                            borderColor: kFailedColor,
                            hasBorder: true,
                            textColor: kFailedColor,
                            onPressed: () => deleteFunction(v?.id),
                          ),
                        if (AppService.hasPermission(
                            PermissionType.UPDATE_ROLE))
                          SizedBox(width: 16.w),
                        if (AppService.hasPermission(
                            PermissionType.UPDATE_ROLE))
                          Button(
                            text: 'Edit',
                            borderColor: kPrimaryColor,
                            hasBorder: true,
                            textColor: kPrimaryColor,
                            onPressed: () => navigateToCreateRolePage(v),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  navigateToCreateRolePage(data) {
    Navigator.pushNamed(
      context,
      AddRoleScreen.routeName,
    );
  }
}
