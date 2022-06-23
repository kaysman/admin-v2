import 'package:lng_adminapp/data/models/pagination_options.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data_drivers.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/presentation/screens/sub-users/subuser_info.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
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
            buildHeader(context, state),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${state.subusers?.items?.length} users",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Spacer(),
                            Text(
                              'Results per page',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Spacings.SMALL_HORIZONTAL,
                            SizedBox(
                              width: 60,
                              child: DecoratedDropdown<int>(
                                value: state.perPage,
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
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(top: 8, bottom: 12),
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
                                rows: tableRows(state),
                              ),
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
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  buildHeader(BuildContext context, SubuserState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text(
          "Sub-users",
          style: Theme.of(context).textTheme.headline1,
        ),
        Spacings.SMALL_HORIZONTAL,
        SizedBox(
          width: 280,
          height: 34,
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
              hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                    color: kGrey1Color,
                  ),
              prefixIcon: SearchIcon(),
            ),
            onFieldSubmitted: (v) {
              if (v.isNotEmpty) {
                subUserBloc.loadSubusers(
                    PaginationOptions(filter: v, limit: state.perPage));
              }
            },
          ),
        ),
        if (AppService.hasPermission(PermissionType.CREATE_USER)) Spacer(),
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
              Navigator.pushNamed(context, AddSubuserScreen.routeName);
            },
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

  List<DataRow> tableRows(SubuserState state) {
    List<User>? items = state.subusers?.items;
    return List.generate(items?.length ?? 0, (index) {
      var user = items![index];
      return DataRow(
        // It is not necessary for this list
        // onSelectChanged: (v) {},
        cells: <DataCell>[
          DataCell(
            Center(
              child: CircleAvatar(
                radius: 18,
                child: user.photoUrl == null
                    ? SizedBox()
                    : Image.network(user.photoUrl!),
              ),
            ),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text(
              "${user.firstName} ${user.lastName}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text(
              "${user.phoneNumber}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text(
              "${user.specificTypeOfUser?.name}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () => navigateToUserDetailsPage(user),
          ),
          DataCell(
            Text(
              "0 Team",
              style: Theme.of(context).textTheme.bodyText1,
            ),
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
