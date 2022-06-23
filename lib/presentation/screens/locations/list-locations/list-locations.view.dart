import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/services/location.service.dart';
import 'package:lng_adminapp/presentation/screens/dialog/delete/delete-dialog.bloc.dart';
import 'package:lng_adminapp/presentation/screens/locations/create-location/create-location.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location-information/location-information.view.dart';
import 'package:lng_adminapp/presentation/screens/locations/location.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
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
    'Country code',
    'Postal code',
  ];

  @override
  void initState() {
    // TODO: implement initState
    locationBloc = context.read<LocationBloc>();
    if (locationBloc.state.locations == null) {
      locationBloc.loadLocations();
    }
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
                    buildHeader(context, locationState),
                    SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 14.h,
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
                                      width: 60,
                                      child: DecoratedDropdown<int>(
                                        value: locationState.perPage,
                                        icon: null,
                                        items: [10, 20, 50],
                                        onChanged: (v) {
                                          if (v != null) {
                                            locationBloc.setPerPageAndLoad(v);
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
    ;
  }

  buildHeader(BuildContext context, LocationState state) {
    return Row(
      children: [
        Text(
          'Locations',
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
                locationBloc.loadLocations(PaginationOptions(
                  filter: v,
                  limit: state.perPage,
                ));
              }
            },
          ),
        ),
        Spacer(),
        Spacings.SMALL_HORIZONTAL,
        InkWell(
          onTap: () async {
            await locationBloc.loadLocations();
          },
          child: Icon(Icons.refresh),
        ),
        Spacings.SMALL_HORIZONTAL,
        Row(
          children: [
            AppIcons.svgAsset(
              AppIcons.help,
            ),
            if (AppService.hasPermission(PermissionType.CREATE_ADDRESS))
              SizedBox(width: 24.w),
            if (AppService.hasPermission(PermissionType.CREATE_ADDRESS))
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
    );
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
            Text(
              "${location.name ?? '-'}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text(
              "${location.type ?? '-'}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text(
              "${location.address?.addressLineOne ?? '-'}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text(
              "${location.address?.countryCode ?? '-'}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
          DataCell(
            Text(
              "${location.address?.postalCode ?? '-'}",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
            onTap: () => navigateToLocationDetailsPage(location),
          ),
        ],
      );
    });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1);
    await context
        .read<LocationBloc>()
        .loadLocations(PaginationOptions(page: previous));
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1);
    await context
        .read<LocationBloc>()
        .loadLocations(PaginationOptions(page: next));
  }

  navigateToLocationDetailsPage(data) {
    LocationService.selectedLocation.value = data;
    Navigator.pushNamed(context, LocationInformation.routeName);
  }
}
