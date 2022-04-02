import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/role/create-role.model.dart';
import 'package:lng_adminapp/data/models/role/module.model.dart';
import 'package:lng_adminapp/data/models/role/permission.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class RoleBloc extends Cubit<RoleState> {
  RoleBloc() : super(RoleState()) {
    loadRoles();
    loadModules();
  }

  loadRoles([String page = '1', String limit = '10']) async {
    final queryParams = <String, String>{"page": page, "limit": limit};
    emit(state.updateState(roleStatus: RoleStatus.loading));

    try {
      var roles = await RoleService.getRoles(queryParams);

      emit(state.updateState(
        roleStatus: RoleStatus.idle,
        roles: roles,
      ));
    } catch (_) {
      emit(state.updateState(roleStatus: RoleStatus.error));
    }
  }

  loadModules() async {
    emit(state.updateState(moduleStatus: ModuleStatus.loading));
    try {
      var modules = await RoleService.getModules();
      RoleService.modules.value = modules;
      emit(state.updateState(
        moduleStatus: ModuleStatus.idle,
        modules: modules,
      ));
    } catch (_) {
      print('it ended here');
      emit(state.updateState(moduleStatus: ModuleStatus.error));
    }
  }

  createRole(CreateRole data, BuildContext context, bool isUpdating,
      Role? role) async {
    emit(state.updateState(createRoleStatus: CreateRoleStatus.loading));
    try {
      var result = await RoleService.createRole(data, isUpdating);

      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedRole(data, role);
        }
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.SUCCESS,
            message: result.message,
            onClose: () => {
              emit(
                state.updateState(
                  createRoleStatus: CreateRoleStatus.success,
                ),
              ),
              Navigator.pop(context),
              Navigator.pop(context),
              loadRoles(),
            },
          ),
        );
      } else {
        showWhiteDialog(
          context,
          ResponseDialog(
            type: DialogType.ERROR,
            message: result.message,
            onClose: () {},
          ),
        );
      }
    } catch (_) {
      emit(state.updateState(createRoleStatus: CreateRoleStatus.idle));
    }
  }

  updateGlobalSelectedRole(CreateRole data, Role? role) {
    Role updatedRole = Role(
      id: data.id,
      name: data.name,
      description: data.description,
      permissions: role?.permissions,
      createdAt: role?.createdAt,
    );
    RoleService.selectedRole.value = updatedRole;
  }
}

enum RoleStatus { idle, loading, error }
enum ModuleStatus { idle, loading, error }
enum CreateRoleStatus { idle, loading, success, error }

class RoleState {
  final RoleStatus? roleStatus;
  final ModuleStatus? moduleStatus;
  final RoleList? roles;
  final List<Module>? modules;
  final CreateRoleStatus? createRoleStatus;

  RoleState({
    this.roleStatus = RoleStatus.idle,
    this.moduleStatus = ModuleStatus.idle,
    this.roles,
    this.modules,
    this.createRoleStatus = CreateRoleStatus.idle,
  });

  RoleState updateState({
    RoleStatus? roleStatus,
    ModuleStatus? moduleStatus,
    RoleList? roles,
    List<Module>? modules,
    CreateRoleStatus? createRoleStatus,
  }) {
    return RoleState(
      roleStatus: roleStatus ?? this.roleStatus,
      moduleStatus: moduleStatus ?? this.moduleStatus,
      roles: roles ?? this.roles,
      modules: modules ?? this.modules,
      createRoleStatus: createRoleStatus ?? this.createRoleStatus,
    );
  }
}
