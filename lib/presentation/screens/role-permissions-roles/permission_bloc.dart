import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lng_adminapp/data/models/role/permission.model.dart';
import 'package:lng_adminapp/data/services/role.service.dart';

enum ListPermissionsStatus { idle, loading, error }

class PermissionState {
  final ListPermissionsStatus listPermissionsStatus;
  final PermissionsByModule? permissions;
  PermissionState({
    this.listPermissionsStatus = ListPermissionsStatus.idle,
    this.permissions,
  });

  PermissionState updateState({
    ListPermissionsStatus? listPermissionsStatus,
    PermissionsByModule? permissions,
  }) {
    return PermissionState(
      listPermissionsStatus:
          listPermissionsStatus ?? this.listPermissionsStatus,
      permissions: permissions ?? this.permissions,
    );
  }
}

class PermissionBloc extends Cubit<PermissionState> {
  PermissionBloc() : super(PermissionState()) {
    loadPermissions();
  }

  Future<void> loadPermissions() async {
    emit(state.updateState(
        listPermissionsStatus: ListPermissionsStatus.loading));
    try {
      var res = await RoleAndPermissionsService.getPermissionByModule();
      emit(state.updateState(
        listPermissionsStatus: ListPermissionsStatus.idle,
        permissions: res,
      ));
    } catch (_) {
      emit(state.updateState(
          listPermissionsStatus: ListPermissionsStatus.error));
    }
  }
}
