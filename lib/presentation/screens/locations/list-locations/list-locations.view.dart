import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/create-location.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location-information/location-information.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';

class ListLocations extends StatelessWidget {
  static const String routeName = 'manage-locations';

  const ListLocations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocationList();
  }
}

class LocationList extends StatefulWidget {
  LocationList({Key? key}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  late LocationBloc locationBloc;
  List<String> columnNames = [
    'Name',
    'Type',
    'Address',
    'Contact name',
    'Phone'
  ];

  @override
  void initState() {
    // TODO: implement initState
    locationBloc = context.read<LocationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreyBackground,
      body: Container(
        margin: EdgeInsets.all(Spacings.kSpaceLittleBig),
        child: BlocBuilder<LocationBloc, LocationState>(
          bloc: locationBloc,
          builder: (context, locationState) {
            var _listLocationStatus = locationState.listLocationStatus;
            var _locations = locationState.locationItems;
            var _meta = locationState.locations?.meta;

            if (_listLocationStatus == ListLocationStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (_listLocationStatus == ListLocationStatus.error) {
              return TryAgainButton(
                tryAgain: () async {
                  await locationBloc.loadLocations();
                },
              );
            }
            return BlocConsumer<DeleteDialogBloc, DeleteDialogState>(
              listener: (context, deleteDialogState) {
                if (deleteDialogState.deleteLocationStatus ==
                    DeleteLocationStatus.success) {
                  locationBloc.loadLocations();
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
                                'Locations',
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
                            if (AppService.hasPermission(
                                PermissionType.CREATE_ADDRESS))
                              SizedBox(width: 24.w),
                            if (AppService.hasPermission(
                                PermissionType.CREATE_ADDRESS))
                              Button(
                                primary: Theme.of(context).primaryColor,
                                text: 'Add new location',
                                textColor: kWhite,
                                permissions: [PermissionType.CREATE_ADDRESS],
                                onPressed: () {
                                  LocationService.selectedLocation.value = null;
                                  Navigator.pushNamed(
                                    context,
                                    CreateLocation.routeName,
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
                                    '${_locations?.length} locations available',
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
                                      value: locationState.perPage,
                                      icon: null,
                                      items: ['10', '20', '50'],
                                      onChanged: (v) {
                                        locationBloc.setPerPageAndLoad(v);
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
    ;
  }

  get tableColumns {
    return List.generate(columnNames.length, (index) {
      var name = columnNames[index];
      return DataColumn(label: Text(name));
    });
  }

  get tableRows {
    List<Location>? locations = locationBloc.state.locationItems;
    return List.generate(locations!.length, (index) {
      var location = locations[index];
      return DataRow(
        // It is not necessary for this list
        // onSelectChanged: (v) {},
        cells: <DataCell>[
          DataCell(
            Text("${location.name ?? '-'}"),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text("${location.type ?? '-'}"),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text("${location.address?.addressLineOne ?? '-'}"),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text("-"),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text("-"),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context.read<LocationBloc>().loadLocations(previous);
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context.read<LocationBloc>().loadLocations(next);
  }

  navigateToLocationDetailsPage(data) {
    LocationService.selectedLocation.value = data;
    Navigator.pushNamed(context, LocationInformation.routeName);
  }
}
