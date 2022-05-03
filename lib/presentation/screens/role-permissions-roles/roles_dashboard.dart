import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/role.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/add_role_screen/add_role_screen.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role.bloc.dart';
import 'package:lng_adminapp/presentation/screens/role-permissions-roles/role_details_screen/role_details_screen.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../data/enums/status.enum.dart';

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

            if (_roles != null && _roles.isEmpty)
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
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0.35.sw,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Roles',
                                style: GoogleFonts.inter(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: TextField(
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
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          color: kGrey1Color,
                                        ),
                                    prefixIcon: SearchIcon(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            SmallCircleButton(
                                child: AppIcons.svgAsset(AppIcons.help)),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_ROLE))
                              SizedBox(width: 26),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_ROLE))
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddRoleScreen.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 9,
                                    horizontal: 16,
                                  ),
                                ),
                                child: Text(
                                  'Add New Role',
                                  style: GoogleFonts.inter(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 45,
                              color: const Color(0xff000000).withOpacity(0.1),
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
                          Container(
                            margin: EdgeInsets.fromLTRB(32.sp, 32.sp, 0, 0),
                            child: Text('${_roles?.length} Roles'),
                          ),
                          // Table view
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 14,
                              ),
                              child: ScrollableWidget(
                                child: DataTable(
                                  checkboxHorizontalMargin: 18.w,
                                  dataRowHeight: 58.h,
                                  headingRowColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return kSecondaryColor.withOpacity(0.6);
                                      }
                                      return kSecondaryColor;
                                    },
                                  ),
                                  dataRowColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return kGrey5Color;
                                      }
                                      return kWhite;
                                    },
                                  ),
                                  headingTextStyle: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  dataTextStyle:
                                      GoogleFonts.inter(fontSize: 16.sp),
                                  columnSpacing: 200.w,
                                  horizontalMargin: 12.w,
                                  dividerThickness: 0.4.sp,
                                  headingRowHeight: 58.h,
                                  sortColumnIndex: sortColumnIndex,
                                  sortAscending: sortAscending,
                                  columns: tableColumns,
                                  rows: tableRows,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                );
              },
            );
          },
        ),
      ),
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
            Text("${role.name}"),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text("${role.description}"),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text("${role.createdAt}"),
            onTap: () => navigateToRoleDetailsPage(role),
          ),
          DataCell(
            Text("${role.permissions?.length}"),
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
