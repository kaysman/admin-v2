import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/lng.service.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';
import 'package:lng_adminapp/presentation/screens/index/index.cubit.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthState initAppState;
  final IndexCubit indexBloc;

  AuthBloc(this.initAppState, this.indexBloc) : super(initAppState) {
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
      final credentials = await LngService.login(data);

      var disk = (await LocalStorage.instance);
      disk.credentials = credentials;
      emit(AuthState.authenticated(credentials));

      ApiClient.setCredentials(credentials);

      await loadIdentity(credentials.id);
    } catch (_) {
      setAuthLoggedOut();
    }
  }

  setAuthLoggedOut() {
    ApiClient.setCredentials(null);
    AppService.instance.resetDisk();
    AppService.currentUser.value = null;
    emit(AuthState.unauthenticated());
    indexBloc.assignPage(0);
  }
}
