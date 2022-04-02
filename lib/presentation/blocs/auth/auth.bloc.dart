import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/lng.service.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthState initAppState;

  AuthBloc(this.initAppState) : super(initAppState) {
    if (this.initAppState.status == AuthStatus.authenticated) {
      this.loadIdentity();
    }
  }

  loadIdentity([String? userId]) async {
    emit(state.copyWith(identityStatus: IdentityStatus.loading));
    try {
      var identity = await LngService.getUserIdentity(
          userId ?? (await LocalStorage.instance).credentials?.id);
      AppService.currentUser.value = identity;
      emit(state.copyWith(
          identity: identity, identityStatus: IdentityStatus.idle));
    } catch (_) {
      emit(state.copyWith(identityStatus: IdentityStatus.error));
    }
  }

  setAuthLoggedIn(Map<String, dynamic> data) async {
    try {
      // fetch credentials (access token, user id)
      final credentials = await LngService.login(data);
      // store credentials in memory
      var disk = (await LocalStorage.instance);
      disk.credentials = credentials;
      emit(AuthState.authenticated(credentials));
      // store credentials in api client
      ApiClient.setCredentials(credentials);
      // fetch user data using credentials
      await loadIdentity(credentials.id);
    } catch (_) {
      print(_.toString());
      setAuthLoggedOut();
    }
  }

  setAuthLoggedOut() {
    ApiClient.setCredentials(null);
    AppService.instance.resetDisk();
    AppService.currentUser.value = null;
    emit(AuthState.unauthenticated());
  }
}
