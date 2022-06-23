import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data_drivers.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';
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
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
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
    driverBloc = context.read<DriverBloc>();
    if (driverBloc.state.drivers == null) {
      driverBloc.loadDrivers();
    }

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
                    buildHeader(context, driverState),
                    SizedBox(height: 24),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 14,
                          ),
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
                                padding: const EdgeInsets.only(bottom: 12),
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
                                      width: 60,
                                      child: DecoratedDropdown<int>(
                                        value: driverState.perPage,
                                        icon: null,
                                        items: [10, 20, 50],
                                        onChanged: (int? v) {
                                          if (v != null) {
                                            driverBloc.setPerPageAndLoad(v);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                      }),
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

  buildHeader(BuildContext context, DriverState driverState) {
    return Row(
      children: [
        Text(
          'Drivers',
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
                driverBloc.loadDrivers(
                    PaginationOptions(filter: v, limit: driverState.perPage));
              }
            },
          ),
        ),
        Spacer(),
        Spacings.SMALL_HORIZONTAL,
        Row(
          children: [
            AppIcons.svgAsset(AppIcons.help),
            SizedBox(width: 24.w),
            if (AppService.hasPermission(PermissionType.CREATE_DRIVER))
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
    );
  }

  get tableColumns {
    return List.generate(columnNames.length, (index) {
      var name = columnNames[index];
      return DataColumn(
        label: Text(name, style: Theme.of(context).textTheme.bodyText1),
      );
    });
  }

  get tableRows {
    List<User>? drivers = driverBloc.state.driverItems;
    return List.generate(drivers!.length, (index) {
      var driver = drivers[index];
      final data = [
        "${driver.firstName} ${driver.lastName}",
        "${driver.phoneNumber}",
        "${driver.driver?.address?.addressLineOne ?? ''}",
        "0 Team",
      ];

      final cells = List.generate(
        data.length,
        (index) => DataCell(
          Text(
            data[index],
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          onTap: () => navigateToDriverDetailsPage(driver),
        ),
      );

      cells.insert(
        0,
        DataCell(
          Center(
            child: Container(
              width: 26,
              height: 26,
              child: CircleAvatar(
                radius: 20.r,
                child: driver.photoUrl == null
                    ? SizedBox()
                    : Image.network(driver.photoUrl!),
              ),
            ),
          ),
          onTap: () => navigateToDriverDetailsPage(driver),
        ),
      );

      return DataRow(cells: cells);
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1);
    await context
        .read<DriverBloc>()
        .loadDrivers(PaginationOptions(page: previous));
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1);
    await context.read<DriverBloc>().loadDrivers(PaginationOptions(page: next));
  }

  navigateToDriverDetailsPage(data) {
    UserService.selectedDriver.value = data;
    // ScreenArgument args = ScreenArgument(data: data);
    Navigator.pushNamed(context, DriverInformation.routeName);
  }
}
