import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/services/app.service.dart';

import '../../../data/services/lng.service.dart';
import '../../blocs/auth/auth.bloc.dart';

///
/// [STATES]
///
///

enum ChangepasswordStatus { idle, loading, error, success }
enum SettingsStatus { initial, loading, success, error }

class SettingsState {
  final SettingsStatus? status;
  final ChangepasswordStatus changepasswordStatus;

  SettingsState({
    this.status,
    this.changepasswordStatus = ChangepasswordStatus.idle,
  });

  SettingsState update(
      {SettingsStatus? status, ChangepasswordStatus? changepasswordStatus}) {
    return SettingsState(
      status: status ?? this.status,
      changepasswordStatus: changepasswordStatus ?? this.changepasswordStatus,
    );
  }
}

class SettingsBloc extends Cubit<SettingsState> {
  SettingsBloc(this.authBloc)
      : super(SettingsState(status: SettingsStatus.initial));

  final AuthBloc authBloc;

  updateUser(Map<String, dynamic> userIdentity) async {
    emit(state.update(status: SettingsStatus.loading));
    try {
      var res = await LngService.updateUserIdentity(userIdentity);
      log(res.toString());
      emit(state.update(status: SettingsStatus.error));
    } catch (_) {
      emit(state.update(status: SettingsStatus.error));
    }
  }

  changePassword(String oldPassword, String newPassword) async {
    emit(state.update(changepasswordStatus: ChangepasswordStatus.loading));
    try {
      var res = await LngService.changePassword(oldPassword, newPassword);
      if (res == true) {
        emit(state.update(changepasswordStatus: ChangepasswordStatus.success));
        if (AppService.currentUser.value != null) {
          await authBloc.setAuthLoggedOut();
        }
      }
    } catch (_) {
      emit(state.update(changepasswordStatus: ChangepasswordStatus.error));
    }
  }
}
