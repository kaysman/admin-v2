import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/data_drivers.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/presentation/screens/sub-users/subuser_info.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../data/enums/status.enum.dart';
import '../../../data/services/app.service.dart';
import 'add_subuser/add_subuser.dart';
import 'subuser_bloc.dart';

class ManageSubusersScreen extends StatefulWidget {
  static const String routeName = 'manage-subusers';
  const ManageSubusersScreen({Key? key}) : super(key: key);

  @override
  State<ManageSubusersScreen> createState() => _ManageSubusersScreenState();
}

class _ManageSubusersScreenState extends State<ManageSubusersScreen> {
  int sortColumnIndex = 0;
  bool sortAscending = true;

  late SubuserBloc subUserBloc;

  String? daysFilter;
  String? viewType;
  int? perPage;

  List<String> showTypes = [
    'All (50)',
    'Pickup (32)',
    'Transit(12)',
    'Delivery (6)'
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    subUserBloc = BlocProvider.of<SubuserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGrey5Color,
      padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
      child: BlocBuilder<SubuserBloc, SubuserState>(builder: (context, state) {
        var _listDriverStatus = state.listSubuserStatus;
        var _drivers = state.subusers;
        var _meta = state.subusers?.meta;

        if (_listDriverStatus == ListSubuserStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_listDriverStatus == ListSubuserStatus.error) {
          return TryAgainButton(
            tryAgain: () async {
              await subUserBloc.loadSubusers();
            },
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 34,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    "Sub-users",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Spacings.SMALL_HORIZONTAL,
                  SizedBox(
                    width: 260,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(
                            color: kWhite,
                            width: 0.0,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle:
                            Theme.of(context).textTheme.headline5?.copyWith(
                                  color: kGrey1Color,
                                ),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(10.sp),
                          child: AppIcons.svgAsset(AppIcons.search),
                        ),
                      ),
                      onFieldSubmitted: (v) {
                        if (v.isNotEmpty) {
                          subUserBloc
                              .loadSubusers(PaginationOptions(filter: v));
                        }
                      },
                    ),
                  ),
                  if (AppService.hasPermission(PermissionType.CREATE_USER))
                    Spacer(),
                  if (AppService.hasPermission(PermissionType.CREATE_USER))
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Add new Sub-user",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: kWhite),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AddSubuserScreen.routeName);
                      },
                    ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      child: Row(
                        children: [
                          ...showTypes.map((e) {
                            final selected =
                                selectedIndex == showTypes.indexOf(e);
                            return InkWell(
                              onTap: () {
                                if (!selected) {
                                  setState(() {
                                    selectedIndex = showTypes.indexOf(e);
                                  });
                                }
                              },
                              child: Card(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                color: selected ? kSecondaryColor : kWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 9,
                                  ),
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                            color: selected
                                                ? kPrimaryColor
                                                : kText1Color),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                      indent: 0,
                      endIndent: 0,
                      color: kGrey3Color,
                      thickness: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "120 Unassigned tasks",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Spacer(),
                                Text(
                                  'Results per page',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Spacings.SMALL_HORIZONTAL,
                                SizedBox(
                                  width: 85,
                                  child: DecoratedDropdown<int>(
                                    value: perPage,
                                    icon: null,
                                    items: [10, 25, 50],
                                    onChanged: (v) {
                                      if (v != null) {
                                        subUserBloc.setPerPageAndLoad(v);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            // Table view
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.w,
                                  vertical: 14.h,
                                ),
                                child: ScrollableWidget(
                                  child: DataTable(
                                    dataRowHeight: 56.h,
                                    headingRowColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return kSecondaryColor
                                              .withOpacity(0.6);
                                        }
                                        return kSecondaryColor;
                                      },
                                    ),
                                    dataRowColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return kGrey5Color;
                                        }
                                        return kWhite;
                                      },
                                    ),
                                    headingTextStyle: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    dataTextStyle: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    columnSpacing: 120.w,
                                    horizontalMargin: 12.w,
                                    dividerThickness: 0.4.sp,
                                    showBottomBorder: false,
                                    headingRowHeight: 34.h,
                                    sortColumnIndex: sortColumnIndex,
                                    sortAscending: sortAscending,
                                    columns: tableColumns,
                                    rows: tableRows(state),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Pagination(
                      metaData: _meta,
                      goPrevious: () => loadPrevious(_meta),
                      goNext: () => loadNext(_meta),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  get tableColumns {
    return List.generate(columnNames.length, (index) {
      var name = columnNames[index];
      return DataColumn(label: Text(name));
    });
  }

  List<DataRow> tableRows(SubuserState state) {
    List<User>? items = state.subusers?.items;
    return List.generate(items?.length ?? 0, (index) {
      var user = items![index];
      return DataRow(
        // It is not necessary for this list
        // onSelectChanged: (v) {},
        cells: <DataCell>[
          DataCell(
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: user.photoUrl != null
                  ? Image.network(user.photoUrl!, height: 30.r, width: 30.r)
                  : CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/wwe.png'),
                    ),
            ),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text("${user.firstName} ${user.lastName}"),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text("${user.phoneNumber}"),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text("${user.specificTypeOfUser?.name}"),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text("0 Team"),
            onTap: () => navigateToUserDetailsPage(user),
          ),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1);
    await context
        .read<SubuserBloc>()
        .loadSubusers(PaginationOptions(page: previous));
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1);
    await context
        .read<SubuserBloc>()
        .loadSubusers(PaginationOptions(page: next));
  }

  navigateToUserDetailsPage(User data) {
    UserService.selectedDriver.value = data;
    Navigator.pushNamed(
      context,
      SubadminInfoScreen.routeName,
      arguments: data,
    );
  }
}
