import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/presentation/screens/dashboard/dashboard.screen.dart';
import 'package:lng_adminapp/presentation/screens/drivers/list-drivers/list-driver.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/list-locations/list-locations.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/list-merchants/list-merchants.view.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/list-orders/prepare-order-list.view.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/roles_dashboard.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/presentation/screens/teams/list-teams/list-teams.view.dart';
import 'package:lng_adminapp/presentation/screens/tracking/tracking_page.dart';
import 'package:lng_adminapp/shared.dart';
import '../../blocs/auth/auth.bloc.dart';
import '../../blocs/auth/auth.state.dart';
import '../operational_flow/operational_flow_list.dart';
import '../sub-users/subusers_table.dart';
import 'index.cubit.dart';

class IndexScreen extends StatelessWidget {
  static const String routeName = 'index';
  const IndexScreen({Key? key}) : super(key: key);

  static bool hasPermission(AuthState state, PermissionType code) {
    var codes = state.identity?.role?.permissions?.map((e) => e.code).toList();
    if (codes != null && codes.where((v) => v == code).length > 0) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<SideBarItem> menuItems = [
          SideBarItem(
            icon: AppIcons.dashboard,
            text: "Dashboard",
            bodyBuilder: (context) => DashboardScreen(),
          ),
          if (hasPermission(state, PermissionType.READ_WORKFLOW))
            SideBarItem(
              icon: AppIcons.flow,
              text: "Operational Flow",
              bodyBuilder: (context) => OperationalFlowList(),
            ),
          if (hasPermission(state, PermissionType.READ_TEAM))
            SideBarItem(
              icon: AppIcons.teams,
              text: "Teams",
              bodyBuilder: (context) => ListTeams(),
            ),
          if (hasPermission(state, PermissionType.READ_DRIVER))
            SideBarItem(
              icon: AppIcons.drivers,
              text: "Drivers",
              bodyBuilder: (context) => ListDrivers(),
            ),
          if (hasPermission(state, PermissionType.READ_MERCHANT))
            SideBarItem(
              icon: AppIcons.merchants,
              text: "Merchants",
              bodyBuilder: (context) => ListMerchants(),
            ),
          if (hasPermission(state, PermissionType.READ_ROLE))
            SideBarItem(
              text: "Roles and Permissions",
              icon: AppIcons.permissions,
              bodyBuilder: (context) => RolesDashboard(),
            ),
          if (hasPermission(state, PermissionType.READ_ORDER))
            SideBarItem(
              icon: AppIcons.bag,
              text: "Orders",
              bodyBuilder: (context) => ManageOrders(),
            ),
          if (hasPermission(state, PermissionType.READ_ORDER))
            SideBarItem(
              icon: AppIcons.bag,
              text: "Prepare Orders",
              bodyBuilder: (context) => PrepareOrdersList(),
            ),
          if (hasPermission(state, PermissionType.READ_REQUEST))
            SideBarItem(
              icon: AppIcons.permissions,
              text: "Pickups",
              bodyBuilder: (context) => ManagePickups(),
            ),
          if (hasPermission(state, PermissionType.READ_ADDRESS))
            SideBarItem(
              icon: AppIcons.locations,
              text: "Locations",
              bodyBuilder: (context) => ListLocations(),
            ),
          if (hasPermission(state, PermissionType.READ_USER))
            SideBarItem(
              icon: AppIcons.subadmin,
              text: "Sub-users",
              bodyBuilder: (context) => ManageSubusersScreen(),
            ),
          SideBarItem(
            icon: AppIcons.settings,
            text: "Settings",
            bodyBuilder: (context) => SettingsLayout(),
          ),
        ];

        return AppLayout(
          sideBarItems: menuItems,
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: BlocConsumer<IndexCubit, int>(
              listener: (context, state) {},
              builder: (context, state) =>
                  menuItems[state].bodyBuilder(context),
            ),
          ),
        );
      },
    );
  }
}
