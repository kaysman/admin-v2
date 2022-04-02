import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/data/services/team.service.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/enums/dialog.enum.dart';

class DeleteDialogBloc extends Cubit<DeleteDialogState> {
  DeleteDialogBloc()
      : super(DeleteDialogState(
            deleteDialogStatus: DeleteDialogStatus.inactive)) {}

  action(DialogType dialogType, ModuleType module, String? input, String id,
      BuildContext context) async {
    emit(state.update(deleteDialogStatus: DeleteDialogStatus.loading));
    emit(state.update(deleteDriverStatus: DeleteDriverStatus.idle));
    emit(state.update(deleteMerchantStatus: DeleteMerchantStatus.idle));
    emit(state.update(deleteTeamStatus: DeleteTeamStatus.idle));

    try {
      if (dialogType == DialogType.DELETE) {
        if (module == ModuleType.DRIVER || module == ModuleType.MERCHANT) {
          var result = await UserService.deleteUser(id);
          if (result.success != null && result.success == true) {
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.success));
            if (module == ModuleType.MERCHANT) {
              emit(state.update(
                  deleteMerchantStatus: DeleteMerchantStatus.success));
            } else {
              emit(
                  state.update(deleteDriverStatus: DeleteDriverStatus.success));
            }
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            if (module == ModuleType.MERCHANT) {
              emit(state.update(
                  deleteMerchantStatus: DeleteMerchantStatus.idle));
            } else {
              emit(state.update(deleteDriverStatus: DeleteDriverStatus.idle));
            }
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.error));
            //TODO: show something else
          }
        } else if (module == ModuleType.TEAM) {
          var result = await TeamService.deleteTeam(id);
          if (result.success != null && result.success == true) {
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.success));
            emit(state.update(deleteTeamStatus: DeleteTeamStatus.success));
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            emit(state.update(deleteTeamStatus: DeleteTeamStatus.idle));
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.error));
            //TODO: show something else
          }
        } else if (module == ModuleType.LOCATION) {
          var result = await LocationService.deleteLocation(id);
          if (result.success != null && result.success == true) {
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.success));
            emit(state.update(
                deleteLocationStatus: DeleteLocationStatus.success));
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            emit(state.update(deleteLocationStatus: DeleteLocationStatus.idle));
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.error));
            //TODO: show something else
          }
        } else if (module == ModuleType.ROLE) {
          var result = await RoleService.deleteRole(id);
          if (result.success != null && result.success == true) {
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.success));
            emit(state.update(deleteRoleStatus: DeleteRoleStatus.success));
            Navigator.pop(context);
            Navigator.pop(context);
          } else {
            emit(state.update(deleteRoleStatus: DeleteRoleStatus.idle));
            emit(state.update(deleteDialogStatus: DeleteDialogStatus.error));
            //TODO: show something else
          }
        }
      } else if (dialogType == DialogType.CONFIRM) {
        // dabby
      }
    } catch (_) {
      throw _;
    }
  }

  void validateString(DialogType dialogType, ModuleType module, String? input) {
    String confirmString =
        '${describeEnum('$dialogType')}${describeEnum('$module')}';
    if (confirmString == input) {
      emit(state.update(deleteDialogStatus: DeleteDialogStatus.active));
    } else {
      emit(state.update(deleteDialogStatus: DeleteDialogStatus.inactive));
    }
  }
}

enum DeleteDialogStatus { idle, loading, error, inactive, active, success }
enum DeleteDriverStatus { success, idle }
enum DeleteMerchantStatus { success, idle }
enum DeleteTeamStatus { success, idle }
enum DeleteLocationStatus { success, idle }
enum DeleteRoleStatus { success, idle }

class DeleteDialogState {
  final DeleteDialogStatus deleteDialogStatus;
  final DeleteDriverStatus deleteDriverStatus;
  final DeleteMerchantStatus deleteMerchantStatus;
  final DeleteTeamStatus deleteTeamStatus;
  final DeleteLocationStatus deleteLocationStatus;
  final DeleteRoleStatus deleteRoleStatus;

  DeleteDialogState({
    this.deleteDialogStatus = DeleteDialogStatus.idle,
    this.deleteDriverStatus = DeleteDriverStatus.idle,
    this.deleteMerchantStatus = DeleteMerchantStatus.idle,
    this.deleteTeamStatus = DeleteTeamStatus.idle,
    this.deleteLocationStatus = DeleteLocationStatus.idle,
    this.deleteRoleStatus = DeleteRoleStatus.idle,
  });

  DeleteDialogState update({
    DeleteDialogStatus? deleteDialogStatus,
    DeleteDriverStatus? deleteDriverStatus,
    DeleteMerchantStatus? deleteMerchantStatus,
    DeleteTeamStatus? deleteTeamStatus,
    DeleteLocationStatus? deleteLocationStatus,
    DeleteRoleStatus? deleteRoleStatus,
  }) {
    return DeleteDialogState(
      deleteDialogStatus: deleteDialogStatus ?? this.deleteDialogStatus,
      deleteDriverStatus: deleteDriverStatus ?? this.deleteDriverStatus,
      deleteMerchantStatus: deleteMerchantStatus ?? this.deleteMerchantStatus,
      deleteTeamStatus: deleteTeamStatus ?? this.deleteTeamStatus,
      deleteLocationStatus: deleteLocationStatus ?? this.deleteLocationStatus,
      deleteRoleStatus: deleteRoleStatus ?? this.deleteRoleStatus,
    );
  }
}
