import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/create-driver.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/driver-information.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/list-drivers/list-driver.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/create-location.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/list-locations/list-locations.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location-information/location-information.view.dart';
import 'package:lng_adminapp/presentation/screens/login/forget_password.dart';
import 'package:lng_adminapp/presentation/screens/login/instruction.dart';
import 'package:lng_adminapp/presentation/screens/merchants/create-merchant/create-merchant.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/list-merchants/list-merchants.view.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchant-information/merchant-information.view.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_map/manage_order.map.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/pickups/request-pickup/request-pickup.view.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/list-orders/prepare-order-list.view.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/add_role_screen/add_role_screen.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/roles_dashboard.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/role_details_screen.dart';
import 'package:lng_adminapp/presentation/screens/screens.dart';
import 'package:lng_adminapp/presentation/screens/settings/edit_org.dart';
import 'package:lng_adminapp/presentation/screens/settings/edit_user.dart';
import 'package:lng_adminapp/presentation/screens/teams/create-team/create-team.view.dart';
import 'package:lng_adminapp/presentation/screens/teams/edit_team.dart';
import 'package:lng_adminapp/presentation/screens/teams/list-teams/list-teams.view.dart';
import 'package:lng_adminapp/presentation/screens/teams/team-information/team-information.view.dart';
import '../screens/manage_flow/create_flow.dart';
import '../screens/operational_flow_list/workflow_detail_page.dart';
import '../screens/sub-users/add_subuser/add_subuser.dart';
import '../screens/sub-users/subuser_info.dart';
import '../screens/sub-users/subusers_table.dart';
import 'helpers.dart';

List<Route<dynamic>> onGenerateInitialRoute(
    String initialRouteName, String initialRoute) {
  switch (initialRouteName) {
    case LoginScreen.routeName:
      return [
        onGenerateRoutes(
          RouteSettings(
            name: initialRouteName,
            arguments: {
              'route': initialRoute,
            },
          ),
        )
      ];
    default:
      return [
        onGenerateRoutes(
          RouteSettings(
            name: initialRouteName,
            arguments: {
              'route': initialRoute,
            },
          ),
        )
      ];
  }
}

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {

    /// index
    case IndexScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => IndexScreen(),
      );

    /// Login Pages
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => LoginScreen(),
      );

    case ForgetPassword.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => ForgetPassword(),
      );

    case InstructionsSentPage.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.CHANGE_PASSWORD],
            InstructionsSentPage(),
            "You don't have permission to change password. Request this permission."),
      );

    /// OPERATIONAL FLOW
    case OperationalFlowList.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_WORKFLOW],
            OperationalFlowList(),
            "You don't have permission to see operational flows"),
      );
    case OperationalFlowDetailScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_WORKFLOW],
            OperationalFlowDetailScreen(
                workflowEntity: settings.arguments as WorkflowEntity),
            "You don't have permission to see operational flows"),
      );
    case CreateOperationalFlowScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.CREATE_WORKFLOW],
            CreateOperationalFlowScreen(
                selectedType: settings.arguments as StandardWorkflowType),
            "You don't have permission to create operational flow"),
      );

    /// DRIVER
    case ListDrivers.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.READ_DRIVER],
          ListDrivers(),
          "You don't have permission to see drivers. Request this permission",
        ),
      );

    case CreateDriver.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.CREATE_DRIVER],
          CreateDriver(),
          "You don't have permission to create driver. Request this permission",
        ),
      );

    case DriverInformation.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.READ_DRIVER],
          DriverInformation(),
          "You don't have permission to see driver information. Request this permission",
        ),
      );

    /// Manage Orders Pages
    case ManageOrdersTableScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.READ_ORDER],
          ManageOrdersTableScreen(
            onViewChanged: settings.arguments as Function(),
          ),
          "You don't have permission to see orders. Request this permission",
        ),
      );

    case ManageOrdersMapScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.READ_ORDER],
          ManageOrdersMapScreen(
            onViewChanged: settings.arguments as Function(),
          ),
          "You don't have permission to see orders. Request this permission",
        ),
      );

    /// Manage Settings Pages
    case SettingsLayout.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => SettingsLayout(),
      );

    case EditUserInfo.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) =>
            EditUserInfo(userIdentity: settings.arguments as User),
      );

    case EditOrganizationInfo.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => EditOrganizationInfo(),
      );

    /// Manage Teams Pages
    case ListTeams.routeName:
      return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => guardedRouteBuilder(
              context,
              [PermissionType.READ_TEAM],
              ListTeams(),
              "You don't have permission to see teams. Request this permission."));
    case TeamInformation.routeName:
      return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => guardedRouteBuilder(
              context,
              [PermissionType.READ_TEAM],
              TeamInformation(),
              "You don't have permission to see teams. Request this permission."));
    case EditTeamInfoPage.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.UPDATE_TEAM],
          EditTeamInfoPage(),
          "You don't have permission to edit team. Request this permission.",
        ),
      );
    case CreateTeam.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.CREATE_TEAM],
          CreateTeam(),
          "You don't have permission to create team. Request this permission.",
        ),
      );

    /// Locations Pages
    case ListLocations.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.READ_ADDRESS],
          ListLocations(),
          "You don't have permission to see locations. Request this permission",
        ),
      );
    case CreateLocation.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.CREATE_ADDRESS],
          CreateLocation(),
          "You don't have permission to create a location. Request this permission",
        ),
      );
    case LocationInformation.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
          context,
          [PermissionType.CREATE_ADDRESS],
          LocationInformation(),
          "You don't have permission to see location information. Request this permission",
        ),
      );

    /// Manage Pickup Pages
    case ManagePickups.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => ManagePickups(),
      );
    case RequestPickup.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => RequestPickup(),
      );

    /// Manage Sub-user Pages
    case ManageSubusersScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_USER],
            ManageSubusersScreen(),
            "You don't have permission to read sub-users. Request this permission."),
      );
    case AddSubuserScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.CREATE_USER],
            AddSubuserScreen(),
            "You don't have permission to create sub-user. Request this permission."),
      );
    case SubadminInfoScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_USER],
            SubadminInfoScreen(user: settings.arguments as User),
            "You don't have permission to read sub-users. Request this permission."),
      );

    /// Manage Merchants Pages
    case ListMerchants.routeName:
      return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (context) => guardedRouteBuilder(
              context,
              [PermissionType.READ_MERCHANT],
              ListMerchants(),
              "You don't have permission to see merchants. Request this permission."));
    case MerchantInformation.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_MERCHANT],
            MerchantInformation(),
            "You don't have permission to see merchant. Request this permission."),
      );
    case CreateMerchant.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.CREATE_MERCHANT],
            CreateMerchant(),
            "You don't have permission to create merchant. Request this permission."),
      );

    /// Manage Preparing Orders Pages
    case PrepareOrdersList.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_ORDER],
            PrepareOrdersList(),
            "You don't have permission to see orders. Request this permission."),
      );

    /// Manage Roles & Permissions Pages
    case RolesDashboard.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_ROLE],
            RolesDashboard(),
            "You don't have permission to see roles."),
      );

    case AddRoleScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.CREATE_ROLE],
            AddRoleScreen(),
            "You don't have permission to create role."),
      );

    case RoleDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.READ_ROLE],
            RoleDetailsScreen(),
            "You don't have permission to read role."),
      );

    /// default
    default:
      return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (context) => guardedRouteBuilder(
            context,
            [PermissionType.LOG_IN],
            LoginScreen(),
            "You are not allowed to login. Request login permission."),
      );
  }
}
