import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/add_role_screen/add_role_screen.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role.bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/role_details_screen.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../data/enums/status.enum.dart';
import '../../../data/models/pagination_options.dart';
import '../orders/manage_order_table/manage_order.table.dart';

class RolesDashboard extends StatefulWidget {
  static const String routeName = 'roles';

  const RolesDashboard({Key? key}) : super(key: key);

  @override
  _RolesDashboardState createState() => _RolesDashboardState();
}

class _RolesDashboardState extends State<RolesDashboard> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  late RoleBloc roleBloc;
  List<String> columnNames = [
    'Name',
    'Description',
    'Creation date',
    'Number of permissions'
  ];

  @override
  void initState() {
    roleBloc = context.read<RoleBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Container(
        margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
        child: BlocBuilder<RoleBloc, RoleState>(
          bloc: roleBloc,
          builder: (context, state) {
            var _roleStatus = state.roleStatus;
            var _roles = state.roles?.items;
            var _meta = state.roles?.meta;
            if (_roleStatus == RoleStatus.loading)
              return const Center(child: CircularProgressIndicator());

            if (_roleStatus == RoleStatus.error)
              return TryAgainButton(
                tryAgain: () async {
                  await roleBloc.loadRoles();
                },
              );

            return BlocConsumer<DeleteDialogBloc, DeleteDialogState>(
              listener: (context, deleteDialogState) {
                if (deleteDialogState.deleteRoleStatus ==
                    DeleteRoleStatus.success) {
                  roleBloc.loadRoles();
                  roleBloc.loadModules();
                }
              },
              listenWhen: (state1, state2) => state1 != state2,
              builder: (context, deleteDialogState) {
                return Column(
                  children: [
                    _header(context, state),
                    SizedBox(height: 24),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 45,
                                    color: const Color(0xff000000)
                                        .withOpacity(0.1),
                                  ),
                                ],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${_roles?.length} Roles',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      Spacer(),
                                      Text(
                                        'Results per page',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      Spacings.SMALL_HORIZONTAL,
                                      SizedBox(
                                        width: 60,
                                        child: DecoratedDropdown<int>(
                                          value: state.perPage,
                                          icon: null,
                                          items: [10, 20, 50],
                                          onChanged: (int? v) {
                                            if (v != null) {
                                              roleBloc.setPerPageAndLoad(v);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Table view
                                ScrollableWidget(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: constraints.maxWidth,
                                    ),
                                    child: DataTable(
                                      border: TableBorder.all(
                                        width: 1.0,
                                        color: Colors.grey.shade100,
                                      ),
                                      sortColumnIndex: sortColumnIndex,
                                      sortAscending: sortAscending,
                                      columns: tableColumns,
                                      rows: tableRows,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Pagination(
                      metaData: _meta,
                      goPrevious: () {},
                      goNext: () {},
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Row _header(BuildContext context, RoleState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Roles',
          style: Theme.of(context).textTheme.headline1,
        ),
        Spacings.SMALL_HORIZONTAL,
        SizedBox(
          width: 280,
          height: 34,
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: kWhite,
                  width: 0.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                    width: 0.0,
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: kWhite,
                  width: 0.0,
                ),
              ),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                    color: kGrey1Color,
                  ),
              prefixIcon: SearchIcon(),
            ),
            onFieldSubmitted: (v) {
              if (v.isNotEmpty) {
                roleBloc.loadRoles(
                    PaginationOptions(filter: v, limit: state.perPage));
              }
            },
          ),
        ),
        Spacer(),
        Spacings.SMALL_HORIZONTAL,
        Row(
          children: [
            AppIcons.svgAsset(
              AppIcons.help,
            ),
            if (AppService.hasPermission(PermissionType.CREATE_ROLE))
              SizedBox(width: 24.w),
            if (AppService.hasPermission(PermissionType.CREATE_ROLE))
              Button(
                primary: Theme.of(context).primaryColor,
                text: 'Add New Role',
                textColor: kWhite,
                permissions: [PermissionType.CREATE_ROLE],
                onPressed: () {
                  Navigator.pushNamed(context, AddRoleScreen.routeName);
                },
              ),
          ],
        ),
      ],
    );
  }

  get tableColumns {
    return List.generate(columnNames.length, (index) {
      var name = columnNames[index];
      return DataColumn(label: Text(name));
    });
  }

  get tableRows {
    return List.generate(roleBloc.state.roles!.items!.length, (index) {
      var role = roleBloc.state.roles!.items![index];
      return DataRow(
        cells: <DataCell>[
          DataCell(
            Text(
              "${role.name}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text(
              "${role.description}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text(
              "${role.createdAt}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text(
              "${role.permissions?.length}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
        ],
      );
    });
  }

  navigateToRoleDetailsPage(data) {
    RoleAndPermissionsService.selectedRole.value = data;
    Navigator.pushNamed(context, RoleDetailsScreen.routeName);
  }
}
