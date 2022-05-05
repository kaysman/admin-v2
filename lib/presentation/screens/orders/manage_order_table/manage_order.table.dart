import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';

import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/driver-assign.dialog.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';
import '../../../shared/components/search_icon.dart';
import 'dialogs/filter_dialog.dart';
import 'dialogs/upload_view.dart';
import 'order_status/order_status.dart';

class ManageOrdersTableScreen extends StatefulWidget {
  static const String routeName = 'manage-order-table';
  const ManageOrdersTableScreen({
    Key? key,
    required this.onViewChanged,
  }) : super(key: key);

  final VoidCallback onViewChanged;

  @override
  State<ManageOrdersTableScreen> createState() => _ManageOrdersTableScreenState();
}

class _ManageOrdersTableScreenState extends State<ManageOrdersTableScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  int sortColumnIndex = 0;
  bool sortAscending = true;

  String? viewType;
  int? perPage;

  List<String> showTypes = ['All (50)', 'Pickup (32)', 'Transit(12)', 'Delivery (6)'];
  int selectedIndex = 0;
  List<Order> selectedOrders = [];

  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const OrderStatusEndDrawer(),
      body: Form(
        key: formKey,
        child: Container(
          color: kGrey5Color,
          padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
          child: BlocBuilder<OrderBloc, OrderState>(
            bloc: orderBloc,
            builder: (context, orderState) {
              var _orderStatus = orderState.orderStatus;
              var _orders = orderState.orders?.items;
              var _meta = orderState.orders?.meta;

              if (_orderStatus == OrderStatus.loading)
                return const Center(child: CircularProgressIndicator());
              if (_orderStatus == OrderStatus.error)
                return TryAgainButton(
                  tryAgain: () async {
                    await orderBloc.loadOrders();
                  },
                );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(context, orderState),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 24),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            child: Row(
                              children: [
                                ...showTypes.map((e) {
                                  final selected = selectedIndex == showTypes.indexOf(e);
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
                                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                              color: selected ? kPrimaryColor : kText1Color),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                if (selectedOrders.isNotEmpty) ...[
                                  Spacer(),
                                  Button(
                                    primary: kWhite,
                                    textColor: kPrimaryColor,
                                    isLoading: orderState.deleteMultipleOrderStatus ==
                                        DeleteMultipleOrderStatus.loading,
                                    text: "Delete orders ${selectedOrders.length}",
                                    onPressed: () async {
                                      await orderBloc.deleteOrders(
                                          selectedOrders.map((Order e) => e.id).toList());
                                      setState(() {
                                        selectedOrders = [];
                                      });
                                    },
                                  ),
                                  SizedBox(width: 12),
                                  Button(
                                    primary: kPrimaryColor,
                                    textColor: kWhite,
                                    isLoading: false,
                                    text: "Assign 1 driver",
                                    onPressed: () {
                                      showWhiteDialog(
                                        context,
                                        SizedBox(
                                          width: 402,
                                          child: DriverAssigningDialog(
                                            selectedOrders: selectedOrders,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(width: 12),
                                  Button(
                                    primary: kPrimaryColor,
                                    textColor: kWhite,
                                    isLoading: false,
                                    text: "Assign multiple drivers",
                                    onPressed: () {},
                                  ),
                                ],
                              ],
                            ),
                          ),
                          horizontalLine(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(32, 8, 32, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${_orders?.length} orders",
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
                                          items: [10, 20, 50],
                                          onChanged: (v) {
                                            setState(() => perPage = v);
                                            print(OrderService.currentPage.value);
                                            if (OrderService.currentPage.value != null) {
                                              orderBloc.loadOrders(
                                                OrderFilterParameters(
                                                  page: OrderService.currentPage.value!,
                                                  limit: v.toString(),
                                                ),
                                              );
                                            }
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
                                        headingRowColor: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (states.contains(MaterialState.selected)) {
                                              return kSecondaryColor.withOpacity(0.6);
                                            }
                                            return kSecondaryColor;
                                          },
                                        ),
                                        dataRowColor: MaterialStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (states.contains(MaterialState.selected)) {
                                              return kGrey5Color;
                                            }
                                            return kWhite;
                                          },
                                        ),
                                        headingTextStyle: Theme.of(context).textTheme.bodyText2,
                                        dataTextStyle: Theme.of(context).textTheme.bodyText1,
                                        columnSpacing: 36.w,
                                        horizontalMargin: 12.w,
                                        dividerThickness: 0.4.sp,
                                        headingRowHeight: 58.h,
                                        onSelectAll: (value) {},
                                        sortColumnIndex: sortColumnIndex,
                                        sortAscending: sortAscending,
                                        columns: this.tableColumns,
                                        rows: tableRows(orderState),
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
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  horizontalLine() {
    return Divider(
      height: 0,
      indent: 0,
      endIndent: 0,
      color: kGrey3Color,
      thickness: 1,
    );
  }

  buildHeader(BuildContext context, OrderState state) {
    return Container(
      height: 34,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text("Orders", style: Theme.of(context).textTheme.headline1),
          Spacings.SMALL_HORIZONTAL,
          SizedBox(
            width: 260,
            child: TextFormField(
              controller: searchController,
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
                hintText: 'Search by any order parameter',
                hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
                      color: kGrey1Color,
                    ),
                prefixIcon: SearchIcon(),
              ),
              onFieldSubmitted: search,
              onSaved: search,
            ),
          ),
          Spacings.SMALL_HORIZONTAL,
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                useRootNavigator: false,
                barrierDismissible: false,
                builder: (context) {
                  return OrderFilterMenu();
                },
              );
            },
            child: Container(
              width: 160,
              height: 34,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  AppIcons.svgAsset(AppIcons.calendar),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
          Spacings.SMALL_HORIZONTAL,
          SizedBox(
            width: 160,
            child: DecoratedDropdown<String>(
              value: viewType,
              icon: AppIcons.svgAsset(AppIcons.columns),
              items: ['Columns', 'Rows'],
              onChanged: (v) {
                setState(() => viewType = v);
              },
            ),
          ),
          Spacer(),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: kBlack, width: 1),
              ),
            ),
            child: Text(
              "Map view",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: widget.onViewChanged,
          ),
          if (AppService.hasPermission(PermissionType.CREATE_ORDER)) ...[
            Spacings.SMALL_HORIZONTAL,
            Button(
                primary: Theme.of(context).primaryColor,
                text: "Add new order",
                textColor: kWhite,
                onPressed: () => addNewOrderTapped(context)),
          ],
        ],
      ),

      // child: Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   textBaseline: TextBaseline.ideographic,
      //   children: [
      //     Text("Orders", style: Theme.of(context).textTheme.headline1),
      //     Spacings.SMALL_HORIZONTAL,
      //     SizedBox(
      //       width: 260,
      //       child: TextFormField(
      //         controller: searchController,
      //         style: Theme.of(context).textTheme.headline5,
      //         decoration: InputDecoration(
      //           contentPadding: EdgeInsets.symmetric(
      //             vertical: 12,
      //             horizontal: 16,
      //           ),
      //           enabledBorder: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(6),
      //             borderSide: const BorderSide(
      //               color: kWhite,
      //               width: 0.0,
      //             ),
      //           ),
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(6),
      //             borderSide: const BorderSide(
      //               color: kWhite,
      //               width: 0.0,
      //             ),
      //           ),
      //           hintText: 'Search by any order parameter',
      //           hintStyle: Theme.of(context).textTheme.headline5?.copyWith(
      //                 color: kGrey1Color,
      //               ),
      //           prefixIcon: SearchIcon(),
      //         ),
      //         onFieldSubmitted: search,
      //         onSaved: search,
      //       ),
      //     ),
      //     Spacings.SMALL_HORIZONTAL,
      //     InkWell(
      //       onTap: () {
      //         showDialog(
      //           context: context,
      //           useRootNavigator: false,
      //           barrierDismissible: false,
      //           builder: (context) {
      //             return OrderFilterMenu();
      //           },
      //         );
      //       },
      //       child: Container(
      //         width: 160,
      //         height: 34,
      //         padding: EdgeInsets.all(8.0),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(6),
      //         ),
      //         child: Row(
      //           children: [
      //             AppIcons.svgAsset(AppIcons.calendar),
      //             Expanded(child: SizedBox()),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Spacings.SMALL_HORIZONTAL,
      //     SizedBox(
      //       width: 160,
      //       child: DecoratedDropdown<String>(
      //         value: viewType,
      //         icon: AppIcons.svgAsset(AppIcons.columns),
      //         items: ['Columns', 'Rows'],
      //         onChanged: (v) {
      //           setState(() => viewType = v);
      //         },
      //       ),
      //     ),
      //     Spacer(),
      //     OutlinedButton(
      //       style: OutlinedButton.styleFrom(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(6),
      //           side: BorderSide(color: kBlack, width: 1),
      //         ),
      //       ),
      //       child: Text(
      //         "Map view",
      //         style: Theme.of(context).textTheme.bodyText2,
      //       ),
      //       onPressed: widget.onViewChanged,
      //     ),
      //     if (AppService.hasPermission(PermissionType.CREATE_ORDER)) ...[
      //       Spacings.SMALL_HORIZONTAL,
      //       Button(
      //           primary: Theme.of(context).primaryColor,
      //           text: "Add new order",
      //           textColor: kWhite,
      //           onPressed: () => addNewOrderTapped(context)),
      //     ],
      //   ],
      // ),
    );
  }

  get tableColumns {
    return List.generate(orderColumnNames.length, (index) {
      var name = orderColumnNames[index];
      return DataColumn(
        label: Text(name),
        onSort: (i, b) {},
      );
    });
  }

  tableRows(OrderState state) {
    List<Order>? orders = orderBloc.state.orders?.items;
    return orders?.map((order) {
      return DataRow(
        selected: selectedOrders.contains(order), // <- check if order selected
        color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return kPrimaryColor.withOpacity(0.08);
          }
          if (states.contains(MaterialState.hovered)) {
            return kGrey5Color;
          }
          return null;
        }),
        onSelectChanged: (v) {
          setState(() {
            if (selectedOrders.contains(order)) {
              selectedOrders.remove(order);
            } else {
              selectedOrders.add(order);
            }
          });
        },
        cells: <DataCell>[
          DataCell(Text("${order.orderReference?.merchantOrderNumber}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.merchant?.companyName}"), onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.allowWeekendDelivery}"), onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryAmount}"), onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryCurrency}"), onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryRequested}"), onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.createdAt}"), onTap: () => openEndDrawer(order)),
          DataCell(statusBall(order.status, false), onTap: () => openEndDrawer(order)),
        ],
      );
    }).toList();
  }

  openEndDrawer(Order order) {
    OrderService.selectedOrder.value = order;
    scaffoldKey.currentState?.openEndDrawer.call();
  }

  addNewOrderTapped(BuildContext context) {
    showWhiteDialog(context, UploadViewModal());
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context.read<OrderBloc>().loadOrders(
          OrderFilterParameters(
            page: previous,
            limit: meta.itemsPerPage.toString(),
          ),
        );
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context.read<OrderBloc>().loadOrders(
          OrderFilterParameters(
            page: next,
            limit: meta.itemsPerPage.toString(),
          ),
        );
  }

  search(String? value) {
    orderBloc.loadOrders(
      OrderFilterParameters(
        page: "1",
        limit: "$perPage",
        searchFilter: value,
      ),
    );
  }
}

/// no need to use this after all, must create new fully customized
/// dropdown like card and display it using stack & positioned
class DecoratedDropdown<T> extends StatelessWidget {
  const DecoratedDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  final T? value;
  final List<T> items;
  final icon;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 12, right: 0),
            hintStyle: TextStyle(
              color: const Color(0xff828282),
              fontSize: 14.sp,
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(
                color: const Color(0xffffffff),
                width: 0.0,
              ),
            ),
            filled: true,
            fillColor: kWhite,
            prefixIcon: icon == null
                ? icon
                : Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: icon,
                  ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              items: items.map<DropdownMenuItem<T>>((e) {
                return DropdownMenuItem<T>(
                  value: e,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$e',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        );
      },
    );
  }
}
