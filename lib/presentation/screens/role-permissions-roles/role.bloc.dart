import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/models/role/create-role.model.dart';
import 'package:lng_adminapp/data/models/role/module.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';
import 'package:lng_adminapp/presentation/screens/dialog/response/response-dialog.view.dart';
import 'package:lng_adminapp/shared.dart';

class RoleBloc extends Cubit<RoleState> {
  RoleBloc() : super(RoleState()) {
    loadRoles();
  }

  loadRoles([PaginationOptions? paginationOptions]) async {
    if (paginationOptions == null) {
      paginationOptions = PaginationOptions(limit: state.perPage);
    }
    emit(state.updateState(roleStatus: RoleStatus.loading));
    try {
      var roles = await RoleAndPermissionsService.getRoles(
        paginationOptions.toJson(),
      );
      emit(state.updateState(roleStatus: RoleStatus.idle, roles: roles));
    } catch (_) {
      emit(state.updateState(roleStatus: RoleStatus.error));
    }
  }

  loadModules() async {
    emit(state.updateState(moduleStatus: ModuleStatus.loading));
    try {
      var modules = await RoleAndPermissionsService.getModules();
      RoleAndPermissionsService.modules.value = modules;
      emit(state.updateState(
        moduleStatus: ModuleStatus.idle,
        modules: modules,
      ));
    } catch (_) {
      emit(state.updateState(moduleStatus: ModuleStatus.error));
    }
  }

  createRole(
    CreateRole data,
    BuildContext context,
    bool isUpdating,
    Role? role,
  ) async {
    emit(state.updateState(createRoleStatus: CreateRoleStatus.loading));
    try {
      var result = await RoleAndPermissionsService.createRole(data, isUpdating);

      if (result.success == true) {
        if (isUpdating) {
          updateGlobalSelectedRole(Role.fromJson(result.data));
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

  setPerPageAndLoad(int v) {
    emit(state.updateState(perPage: v));
    this.loadRoles();
  }

  updateGlobalSelectedRole(Role updatedValue) {
    Role updatedRole = Role(
      id: updatedValue.id,
      name: updatedValue.name,
      description: updatedValue.description,
      permissions: updatedValue.permissions,
      createdAt: updatedValue.createdAt,
    );
    RoleAndPermissionsService.selectedRole.value = updatedRole;
  }
}

enum RoleStatus { idle, loading, error }

enum ModuleStatus { idle, loading, error }

enum CreateRoleStatus { idle, loading, success, error }

class RoleState {
  final RoleStatus? roleStatus;
  final ModuleStatus? moduleStatus;
  final RoleList? roles;
  final int perPage;
  final List<Module>? modules;
  final CreateRoleStatus? createRoleStatus;

  RoleState({
    this.roleStatus = RoleStatus.idle,
    this.moduleStatus = ModuleStatus.idle,
    this.roles,
    this.perPage = 10,
    this.modules,
    this.createRoleStatus = CreateRoleStatus.idle,
  });

  RoleState updateState({
    RoleStatus? roleStatus,
    ModuleStatus? moduleStatus,
    RoleList? roles,
    int? perPage,
    List<Module>? modules,
    CreateRoleStatus? createRoleStatus,
  }) {
    return RoleState(
      roleStatus: roleStatus ?? this.roleStatus,
      moduleStatus: moduleStatus ?? this.moduleStatus,
      roles: roles ?? this.roles,
      perPage: perPage ?? this.perPage,
      modules: modules ?? this.modules,
      createRoleStatus: createRoleStatus ?? this.createRoleStatus,
    );
  }
}
