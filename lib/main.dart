import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/presentation/screens/login/login.dart';
import 'data/services/app.service.dart';
import 'presentation/shared/components/app_observer.dart';
import 'presentation/shared/routes.dart';
import 'presentation/shared/theming.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppService.instance.startApp();
}

class LNGApp extends StatefulWidget {
  final String initialRoute;

  const LNGApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  @override
  State<LNGApp> createState() => _LNGAppState();
}

class _LNGAppState extends State<LNGApp> with WidgetsBindingObserver {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1190),
      builder: (child) {
        return MaterialApp(
          title: 'LNG ADMIN APP',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          onGenerateRoute: onGenerateRoutes,
          initialRoute: LoginScreen.routeName /*LoginScreen.routeName*/,
          onGenerateInitialRoutes: (value) => onGenerateInitialRoute(value, widget.initialRoute),
          builder: (context, home) => AppObserver(
            child: home!,
            navigatorKey: navigatorKey,
          ),
        );
      },
    );
  }
}
