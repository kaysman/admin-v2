import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data_drivers.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/sub-admins/add_subadmin/add_subadmin.dart';
import 'package:lng_adminapp/presentation/screens/sub-admins/subadmin_info.dart';
import 'package:lng_adminapp/shared.dart';

import '../../../data/enums/status.enum.dart';
import '../../../data/services/app.service.dart';

class ManageSubadminsScreen extends StatefulWidget {
  static const String routeName = 'manage-subadmins';
  const ManageSubadminsScreen({Key? key}) : super(key: key);

  @override
  State<ManageSubadminsScreen> createState() => _ManageSubadminsScreenState();
}

class _ManageSubadminsScreenState extends State<ManageSubadminsScreen> {
  int sortColumnIndex = 0;
  bool sortAscending = true;

  String? daysFilter;
  String? viewType;
  String? perPage;

  List<String> showTypes = [
    'All (50)',
    'Pickup (32)',
    'Transit(12)',
    'Delivery (6)'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGrey5Color,
      padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 34,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  "Sub-admins",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Spacings.SMALL_HORIZONTAL,
                SizedBox(
                  width: 260,
                  child: TextField(
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
                      "Add new Sub-admin",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: kWhite),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AddSubadminScreen.routeName,
                      );
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
                                child: DecoratedDropdown(
                                  value: perPage,
                                  icon: null,
                                  items: ['10', '25', '50'],
                                  onChanged: (v) {
                                    setState(() => perPage = v);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Expanded(
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
                                headingTextStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                dataTextStyle:
                                    Theme.of(context).textTheme.bodyText1,
                                columnSpacing: 36.w,
                                horizontalMargin: 12.w,
                                dividerThickness: 0.4.sp,
                                headingRowHeight: 58.h,
                                onSelectAll: (value) {},
                                sortColumnIndex: sortColumnIndex,
                                sortAscending: sortAscending,
                                columns: tableColumns,
                                rows: tableRows,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    return List.generate(driversList.length, (index) {
      var driver = driversList[index];
      return DataRow(
        onSelectChanged: (v) {
          Navigator.pushNamed(context, SubadminInfoScreen.routeName);
        },
        cells: <DataCell>[
          DataCell(
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/john.png'),
            ),
          ),
          DataCell(Text("${driver.name}")),
          DataCell(Text("${driver.phone}")),
          DataCell(Text("${driver.address}")),
          DataCell(
            Text("${driver.teams.toString()}"),
          ),
        ],
      );
    });
  }
}
