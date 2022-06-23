import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/assign.dialog.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';
import '../../../shared/components/search_icon.dart';
import 'dialogs/filter_dialog.dart';
import 'dialogs/select_column.dart';
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
  State<ManageOrdersTableScreen> createState() =>
      _ManageOrdersTableScreenState();
}

class _ManageOrdersTableScreenState extends State<ManageOrdersTableScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  int _sortColumnIndex = 0;
  bool _sortDeliveryTimeAsc = true;
  bool _sortAscending = true;

  DateRangeType? _selectedDateFilter;

  String? viewType;
  int perPage = 10;

  int selectedIndex = 0;
  List<Map<String, dynamic>> selectedOrders = [];
  OrderFilterParameters? orderFilter;
  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    if (orderBloc.state.orders == null) {
      orderBloc.loadOrders(OrderFilterParameters(), true);
    }
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
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          key: formKey,
          child: Container(
            color: kGrey5Color,
            padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
            child: BlocBuilder<OrderBloc, OrderState>(
              bloc: orderBloc,
              builder: (context, orderState) {
                var _orderStatus = orderState.orderStatus;
                var _orders = orderState.orderItems;
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
                    buildHeader(constraints, context, orderState),
                    SizedBox(height: 24),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                                minWidth: constraints.maxWidth,
                              ),
                              child: Container(
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
                                    if (orderState.orders != null)
                                      Container(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 12,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...orderState.statusGroup.keys
                                                  .map((e) {
                                                final selected =
                                                    selectedIndex ==
                                                        orderState
                                                            .statusGroup.keys
                                                            .toList()
                                                            .indexOf(e);
                                                return InkWell(
                                                  onTap: () async {
                                                    if (!selected) {
                                                      setState(() {
                                                        selectedIndex =
                                                            orderState
                                                                .statusGroup
                                                                .keys
                                                                .toList()
                                                                .indexOf(e);
                                                      });
                                                      await orderBloc.loadOrders(
                                                          OrderFilterParameters(
                                                        statusGroup: e,
                                                      ));
                                                    }
                                                  },
                                                  child: Card(
                                                    elevation: 0,
                                                    margin: EdgeInsets.zero,
                                                    color: selected
                                                        ? kSecondaryColor
                                                        : kWhite,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 12,
                                                        vertical: 9,
                                                      ),
                                                      child: Text(
                                                        '${e} (${orderState.statusGroup[e]})',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.copyWith(
                                                              color: selected
                                                                  ? kPrimaryColor
                                                                  : kText1Color,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                              if (selectedOrders
                                                  .isNotEmpty) ...[
                                                SizedBox(width: 12),
                                                Button(
                                                  primary: kWhite,
                                                  textColor: kPrimaryColor,
                                                  isLoading: orderState
                                                          .deleteMultipleOrderStatus ==
                                                      DeleteMultipleOrderStatus
                                                          .loading,
                                                  text:
                                                      "Delete orders ${selectedOrders.length}",
                                                  onPressed: () async {
                                                    await orderBloc
                                                        .deleteOrders(
                                                            selectedOrders
                                                                .map<String>(
                                                                    (e) =>
                                                                        e['id'])
                                                                .toList());
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
                                                  text: "Assign Transfer",
                                                  onPressed: () {
                                                    showWhiteDialog(
                                                      context,
                                                      DriverAssigningDialog(
                                                        isAssignDelivery: false,
                                                        selectedOrders:
                                                            selectedOrders,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(width: 12),
                                                Button(
                                                  primary: kPrimaryColor,
                                                  textColor: kWhite,
                                                  isLoading: false,
                                                  text: "Assign Delivery",
                                                  onPressed: () {
                                                    showWhiteDialog(
                                                      context,
                                                      DriverAssigningDialog(
                                                        isAssignDelivery: true,
                                                        selectedOrders:
                                                            selectedOrders,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    horizontalLine(),
                                    SingleChildScrollView(
                                      padding: const EdgeInsets.fromLTRB(
                                        32,
                                        8,
                                        32,
                                        0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              if (orderState.orders?.meta
                                                      ?.totalItems !=
                                                  null)
                                                Text(
                                                  orderState.orders!.meta!
                                                          .totalItems!
                                                          .toString() +
                                                      " orders",
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
                                                  value: perPage,
                                                  icon: null,
                                                  items: [10, 20, 50],
                                                  onChanged: (v) {
                                                    setState(
                                                        () => perPage = v!);
                                                    if (OrderService.currentPage
                                                            .value !=
                                                        null) {
                                                      orderBloc.loadOrders(
                                                        OrderFilterParameters(
                                                          page: OrderService
                                                              .currentPage
                                                              .value!,
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
                                          ScrollableWidget(
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: constraints.maxWidth,
                                              ),
                                              child: OrderTable(
                                                  _orders, orderState),
                                            ),
                                          ),
                                          Pagination(
                                            metaData: _meta,
                                            goPrevious: () =>
                                                loadPrevious(_meta),
                                            goNext: () => loadNext(_meta),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }

  OrderTable(List<Map<String, dynamic>>? _orders, OrderState orderState) {
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      onSelectAll: (v) => onSelectAll(_orders),
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columns: tableColumns(orderState),
      rows: tableRows(orderState),
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

  onSelectAll(List<Map<String, dynamic>>? orders) {
    if (orders != null) {
      setState(() {
        if (selectedOrders.isEmpty) {
          selectedOrders.addAll(orders);
        } else if (selectedOrders.length < orders.length) {
          selectedOrders = [];
          selectedOrders.addAll(orders);
        } else {
          selectedOrders = [];
        }
      });
    }
  }

  buildHeader(
    BoxConstraints constraints,
    BuildContext context,
    OrderState state,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Orders',
          style: Theme.of(context).textTheme.headline1,
        ),
        Spacings.SMALL_HORIZONTAL,
        searchInput(context),
        Spacings.SMALL_HORIZONTAL,
        if (constraints.maxWidth > 1000) ...[
          dateFilterWidget(context),
          Spacings.SMALL_HORIZONTAL,
          columnsFilter(context, state),
        ],
        Spacings.SMALL_HORIZONTAL,
        InkWell(
          onTap: () async {
            var res = await showDialog(
              context: context,
              useRootNavigator: false,
              barrierDismissible: false,
              builder: (_) => OrderFilterMenu(),
            );
            if (res != null && res is OrderFilterParameters) {
              setState(() {
                orderFilter = res;
              });
            }
          },
          child: Container(
            width: 100,
            height: 34,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                AppIcons.svgAsset(AppIcons.filter),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Filter",
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Spacings.SMALL_HORIZONTAL,
        InkWell(
          onTap: () async {
            await orderBloc.loadOrders(
              OrderFilterParameters(),
              false,
              null,
            );
          },
          child: Icon(Icons.refresh),
        ),
        Spacings.SMALL_HORIZONTAL,
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: Size(100, 34),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: kBlack, width: 1),
              ),
            ),
            child: Text(
              "Map view",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () {
              widget.onViewChanged;
              showSnackBar(
                context,
                Text(
                  'Feature to be released',
                  textAlign: TextAlign.center,
                ),
              );
            }),
        if (AppService.hasPermission(PermissionType.CREATE_ORDER)) ...[
          Spacings.SMALL_HORIZONTAL,
          Button(
            primary: Theme.of(context).primaryColor,
            text: "Add new order",
            textColor: kWhite,
            onPressed: () {
              showWhiteDialog(context, UploadViewModal());
            },
          ),
        ],
      ],
    );
  }

  Widget columnsFilter(BuildContext context, OrderState state) {
    return InkWell(
      onTap: () async {
        await showWhiteDialog<List<OrderColumn>>(
          context,
          SelectColumnDialog(
            selecteds: state.selectedColumns,
            // isDefault: listEquals(
            //   state.selectedColumns,
            //   state.defaultTableColumns,
            // ),
          ),
        );
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcons.svgAsset(AppIcons.columns),
            SizedBox(width: 8),
            Text(
              "Columns",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  searchInput(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 34,
      child: TextFormField(
        controller: searchController,
        style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 12,
            right: 12,
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
          hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: kGrey1Color,
              ),
          prefixIcon: SearchIcon(),
        ),
        onFieldSubmitted: search,
        onSaved: search,
      ),
    );
  }

  dateFilterWidget(BuildContext context) {
    return SizedBox(
      height: 34,
      child: DateFilter(
        dateByValue: _selectedDateFilter,
        onSubmit: (v) async {
          Navigator.of(context).pop();
          setState(() => _selectedDateFilter = v);
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.svgAsset(AppIcons.calendar),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 6),
                child: Text(
                  _selectedDateFilter == null
                      ? "Date"
                      : _selectedDateFilter!.text,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tableColumns(OrderState state) {
    return List.generate(state.selectedColumns.length, (index) {
      var name = state.selectedColumns[index].name;
      return DataColumn(
        label: Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (index == 0) {
              // order #
            } else if (index == 1) {
              // merchant name
            } else if (index == 2) {
              // description
            } else if (index == 3) {
              // weight
            } else if (index == 4) {
              // quantity
            } else if (index == 5) {
              // pickup time
            } else if (index == 6) {
              // delivery time
              if (columnIndex == _sortColumnIndex) {
                _sortAscending = _sortDeliveryTimeAsc = sortAscending;
              } else {
                _sortColumnIndex = columnIndex;
                _sortAscending = _sortDeliveryTimeAsc;
              }
              orderBloc.sortOrders(_sortAscending);
            } else if (index == 7) {
              // status
            }
          });
        },
      );
    });
  }

  tableRows(OrderState state) {
    List<Map<String, dynamic>>? orders = state.orderItems;
    return orders?.map((order) {
      return DataRow(
        selected: selectedOrders.contains(order), // <- check if order selected
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
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
        cells: state.selectedColumns.map<DataCell>(
          (e) {
            if (e.name == 'status') {
              return DataCell(statusBall(order["status"], false));
            } else if (e.name == 'Id') {
              return DataCell(
                Text(
                  "${order['id']}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: "${order['id']}"));
                  AppService.showSnackbar!(
                      "Copied to clipboard", SnackbarType.success);
                  openEndDrawer(order);
                },
              );
            }
            return DataCell(
              Text(
                "${order[e.name]}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onTap: () => openEndDrawer(order),
            );
          },
        ).toList(),
      );
    }).toList();
  }

  openEndDrawer(Map<String, dynamic> order) {
    OrderService.selectedOrder.value = order;
    scaffoldKey.currentState?.openEndDrawer.call();
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

  int getRequestCountByStatus(String? status, List<Map<String, dynamic>> data) {
    int count = 0;

    if (status == "All") {
      count = data.length;
    } else {
      count = data.where((s) => s['status'] == status).toList().length;
    }
    return count;
  }
}

class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  final String title;
  final bool? value;
  final ValueChanged<bool?> onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Checkbox(
            value: value,
            onChanged: this.onPressed,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(title),
          ),
        ),
      ],
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
              isDense: true,
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
