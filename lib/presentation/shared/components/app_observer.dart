// handle any top-level app states such as environment, connectivity, etc.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.bloc.dart';
import 'package:lng_adminapp/presentation/blocs/auth/auth.state.dart';
import 'package:lng_adminapp/presentation/screens/login/login.dart';
import 'package:lng_adminapp/shared.dart';

import '../../blocs/snackbar.bloc.dart';
import 'no_user.dart';

class AppObserver extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  AppObserver({required this.navigatorKey, required this.child});

  @override
  _AppObserverState createState() => _AppObserverState();
}

class _AppObserverState extends State<AppObserver> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO implement dispose
    super.dispose();
  }

  BlocListener snackbarListener() => BlocListener<SnackbarBloc, SnackbarState>(
        listener: (context, SnackbarState state) {
          if (state.type == SnackbarType.success) {
            presentSuccess(state.message!);
          }
          if (state.type == SnackbarType.error) {
            presentError(state.message!);
          }
        },
      );

  authListener() => BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listenWhen: (state1, state2) => state1.status != state2.status,
        listener: (context, state) async {
          if (state.status == AuthStatus.unauthenticated) {
            widget.navigatorKey.currentState!.pushNamedAndRemoveUntil(
              LoginScreen.routeName,
              (_) => false,
            );
          }
        },
      );

  // app screens expect user's identity to be loaded in order to work properly
  // if identity fails to load, content will be replaced with error placeholder
  Widget identityErrorCork({Widget? child}) => BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return (state.identityStatus == IdentityStatus.error &&
                  state.status == AuthStatus.unauthenticated)
              ? NoIdentityScreen()
              : child!;
        },
      );

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MultiBlocListener(
      listeners: [
        authListener(),
        snackbarListener(),
      ],
      child: MediaQuery(
        data: mq.copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          key: _scaffoldKey,
          body: identityErrorCork(
            child: widget.child,
          ),
        ),
      ),
    );
  }

  presentSuccess(String message) {
    if (message.isEmpty) return;
    showSnackBar(
      context,
      Row(
        children: <Widget>[
          Icon(Icons.check_circle_outline, color: Colors.white),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff25D366),
    );
  }

  presentError(String message) {
    if (message.isEmpty) return;
    showSnackBar(
      context,
      Row(
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.white),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xff323232),
    );
  }
}
