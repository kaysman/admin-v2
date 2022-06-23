import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';

class LoginBloc extends Cubit<LoginState> {
  final AuthBloc authBloc;

  LoginBloc(this.authBloc) : super(LoginState(status: LoginStatus.initial));

  login(Map<String, dynamic> data) async {
    emit(state.update(status: LoginStatus.inProgress));
    try {
      await authBloc.setAuthLoggedIn(data);
      emit(state.update(status: LoginStatus.success));
    } catch (error) {
      emit(state.update(status: LoginStatus.initial));
    }
  }

  logout() async {
    try {
      await authBloc.setAuthLoggedOut();
    } catch (_) {}
  }
}

///
/// [STATES]
///
enum LoginStatus {
  initial,
  inProgress,
  success,
  failed,
  loadingUpdatingUser,
  errorUpdatingUser,
  successUpdatingUser
}

class LoginState {
  final LoginStatus? status;
  LoginState({this.status});

  LoginState update({LoginStatus? status}) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
