import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/data_drivers.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/drivers/create-driver/create-driver.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/driver-information/driver-information.view.dart';
import 'package:lng_adminapp/presentation/screens/drivers/drivers.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/shared/colors.dart';
import 'package:lng_adminapp/presentation/shared/components/button.dart';
import 'package:lng_adminapp/presentation/shared/components/pagination.dart';
import 'package:lng_adminapp/presentation/shared/components/scrollable.dart';
import 'package:lng_adminapp/presentation/shared/icons.dart';
import 'package:lng_adminapp/presentation/shared/spacings.dart';

class ListDrivers extends StatelessWidget {
  static const String routeName = 'manage-drivers';
  const ListDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DriverList();
  }
}

class DriverList extends StatefulWidget {
  const DriverList({Key? key}) : super(key: key);

  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  late DriverBloc driverBloc;

  @override
  void initState() {
    // TODO: implement initState
    driverBloc = context.read<DriverBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Container(
        margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
        child: BlocBuilder<DriverBloc, DriverState>(
          bloc: driverBloc,
          builder: (context, driverState) {
            var _listDriverStatus = driverState.listDriverStatus;
            var _drivers = driverState.driverItems;
            var _meta = driverState.drivers?.meta;

            if (_listDriverStatus == ListDriverStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (_listDriverStatus == ListDriverStatus.error) {
              return TryAgainButton(
                tryAgain: () async {
                  await driverBloc.loadDrivers();
                },
              );
            }

            return BlocConsumer<DeleteDialogBloc, DeleteDialogState>(
              listener: (context, deleteDialogState) {
                if (deleteDialogState.deleteDriverStatus ==
                    DeleteDriverStatus.success) {
                  driverBloc.loadDrivers();
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
                            children: [
                              Text(
                                'Drivers',
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
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      child: AppIcons.svgAsset(AppIcons.search),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            AppIcons.svgAsset(
                              AppIcons.help,
                            ),
                            SizedBox(width: 24.w),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_DRIVER))
                              Button(
                                primary: Theme.of(context).primaryColor,
                                text: 'Add New Driver',
                                textColor: kWhite,
                                permissions: [PermissionType.CREATE_DRIVER],
                                onPressed: () {
                                  UserService.selectedDriver.value = null;
                                  Navigator.pushNamed(
                                    context,
                                    CreateDriver.routeName,
                                  );
                                },
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
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
                              child: Row(
                                children: [
                                  Text(
                                    '${_drivers?.length} drivers available',
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Results per page',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Spacings.SMALL_HORIZONTAL,
                                  SizedBox(
                                    width: 85,
                                    child: DecoratedDropdown(
                                      value: driverState.perPage,
                                      icon: null,
                                      items: ['10', '20', '50'],
                                      onChanged: (v) {
                                        driverBloc.setPerPageAndLoad(v);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    rows: tableRows,
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
    List<User>? drivers = driverBloc.state.driverItems;
    return List.generate(drivers!.length, (index) {
      var driver = drivers[index];
      return DataRow(
        // It is not necessary for this list
        // onSelectChanged: (v) {},
        cells: <DataCell>[
          DataCell(
            SizedBox(
              width: 25.w,
              height: 25.w,
              child: driver.photoUrl != null
                  ? Image.network(driver.photoUrl!, height: 30.r, width: 30.r)
                  : CircleAvatar(
                      radius: 20.r,
                      backgroundImage: AssetImage('assets/wwe.png'),
                    ),
            ),
            onTap: () => navigateToDriverDetailsPage(driver),
          ),
          DataCell(
            Text("${driver.firstName} ${driver.lastName}"),
            onTap: () => navigateToDriverDetailsPage(driver),
          ),
          DataCell(
            Text("${driver.phoneNumber}"),
            onTap: () => navigateToDriverDetailsPage(driver),
          ),
          DataCell(
            Text("${driver.driver?.address?.addressLineOne ?? ''}"),
            onTap: () => navigateToDriverDetailsPage(driver),
          ),
          DataCell(
            Text("0 Team"),
            onTap: () => navigateToDriverDetailsPage(driver),
          ),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context.read<DriverBloc>().loadDrivers(previous);
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context.read<DriverBloc>().loadDrivers(next);
  }

  navigateToDriverDetailsPage(data) {
    UserService.selectedDriver.value = data;
    // ScreenArgument args = ScreenArgument(data: data);
    Navigator.pushNamed(context, DriverInformation.routeName);
  }
}
