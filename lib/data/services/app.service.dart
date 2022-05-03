import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/blocs/app_lifecycle.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';
import 'package:lng_adminapp/presentation/blocs/http.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/presentation/screens/index/index.cubit.dart';
import 'package:lng_adminapp/presentation/screens/index/index.screen.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/presentation/screens/login/login.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow_list/flow_bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/presentation/screens/pickups/pickup.bloc.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/prepare-orders.bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role.bloc.dart';
import 'package:lng_adminapp/presentation/screens/settings/settings.bloc.dart';
import 'package:lng_adminapp/presentation/screens/teams/team.bloc.dart';

import '../../main.dart';
import '../../presentation/screens/role-permissions-roles/permission_bloc.dart';
import '../../presentation/screens/sub-users/subuser_bloc.dart';
import '../models/user.model.dart';
import 'api_client.dart';
import 'storage.service.dart';

class AppService {
  static Function(String message, SnackbarType type)? showSnackbar;
  static final currentUser = ValueNotifier<User?>(null);
  static HttpRequestBloc? httpRequests;
  static AppLifecycleBloc? lifecycle;
  static Function? onAuthError;

  AppService._setInstance() {}

  static final AppService instance = AppService._setInstance();

  Future<AuthState> determineInitialAppState() async {
    var disk = await LocalStorage.instance;
    return (disk.credentials == null)
        ? AuthState.unauthenticated()
        : AuthState.authenticated(disk.credentials!);
  }

  resetDisk() async {
    var disk = await LocalStorage.instance;
    disk.credentials = null;
    disk.selectedUser = null;
  }

  static bool hasPermission(PermissionType code) {
    var codes =
        currentUser.value?.role?.permissions?.map((e) => e.code).toList();

    if (codes != null && codes.where((v) => v == code).length > 0) {
      return true;
    }

    return false;
  }

  startApp() async {
    lifecycle = AppLifecycleBloc();
    IndexCubit indexBloc = IndexCubit();
    SnackbarBloc snackbarBloc = SnackbarBloc();
    AuthState initialAppState = await determineInitialAppState();
    AuthBloc authBloc = AuthBloc(initialAppState, indexBloc);
    httpRequests = HttpRequestBloc();

    onAuthError = () => {ApiClient.reset(), authBloc.setAuthLoggedOut()};
    showSnackbar = (String x, SnackbarType type) {
      if (lifecycle!.state.lifecycle == AppLifecycleState.resumed)
        snackbarBloc.showSnackbar(x, type);
    };

    var initialRoute = LoginScreen.routeName;
    var selectedUser = (await LocalStorage.instance).selectedUser;
    if (selectedUser != null) {
      AppService.currentUser.value = selectedUser;
    }
    if (initialAppState.status == AuthStatus.authenticated) {
      initialRoute = IndexScreen.routeName;
    }

    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => indexBloc),
        BlocProvider(create: (_) => authBloc),
        BlocProvider<SettingsBloc>(create: (_) => SettingsBloc(authBloc)),
        BlocProvider(create: (_) => httpRequests!),
        BlocProvider(create: (_) => PickupBloc()),
        BlocProvider(create: (_) => WorkflowBloc()),
        BlocProvider(create: (_) => OrderBloc()),
        BlocProvider(create: (_) => DriverBloc(DeleteDialogBloc())),
        BlocProvider(create: (_) => MerchantBloc(DeleteDialogBloc())),
        BlocProvider(create: (_) => DeleteDialogBloc()),
        BlocProvider(create: (_) => TeamBloc(DeleteDialogBloc())),
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => PrepareOrderBloc()),
        BlocProvider(create: (_) => RoleBloc()),
        BlocProvider(create: (_) => PermissionBloc()),
        BlocProvider(create: (_) => SubuserBloc()),
      ],
      child: LNGApp(initialRoute: initialRoute),
    ));
  }
}
