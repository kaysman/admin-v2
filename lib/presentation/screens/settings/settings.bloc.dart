import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/lng.service.dart';
import '../../blocs/auth/auth.bloc.dart';

///
/// [STATES]
///
enum SettingsStatus { initial, loading, success, error }

class SettingsState {
  final SettingsStatus? status;
  SettingsState({this.status});

  SettingsState update({SettingsStatus? status}) {
    return SettingsState(
      status: status ?? this.status,
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
}
