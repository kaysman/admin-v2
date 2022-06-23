import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/prepare-orders.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../orders/manage_order_table/dialogs/filter_dialog.dart';
import '../../orders/manage_order_table/dialogs/select_column.dart';

class PrepareOrdersList extends StatefulWidget {
  static const String routeName = 'prepare-orders';
  const PrepareOrdersList({Key? key}) : super(key: key);

  @override
  _PrepareOrdersListState createState() => _PrepareOrdersListState();
}

class _PrepareOrdersListState extends State<PrepareOrdersList> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  late PrepareOrderBloc prepareOrderBloc;
  int _sortColumnIndex = 0;
  bool _sortDeliveryTimeAsc = true;
  bool _sortAscending = true;

  String? daysFilter;
  String? viewType;
  int perPage = 10;

  List<String> showTypes = ['All (50)', 'Api (32)', 'Excel(12)', 'Single (6)'];
  int selectedIndex = 0;
  List<Map<String, dynamic>> selectedOrders = [];

  @override
  void initState() {
    prepareOrderBloc = context.read<PrepareOrderBloc>();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          key: formKey,
          child: Container(
            color: kGrey5Color,
            padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
            child: BlocBuilder<PrepareOrderBloc, PrepareOrderState>(
              bloc: prepareOrderBloc,
              builder: (context, state) {
                var _orderStatus = state.prepareOrderStatus;
                var _orders = state.orders?.items;
                var _meta = state.orders?.meta;

                if (_orderStatus == PrepareOrderStatus.loading)
                  return const Center(child: CircularProgressIndicator());
                if (_orderStatus == PrepareOrderStatus.error)
                  return TryAgainButton(
                    tryAgain: () async {
                      await prepareOrderBloc.loadOrders();
                    },
                  );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(constraints, context, state),
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
                                    if (state.orders != null)
                                      Container(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 12,
                                          ),
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ...state.statusGroup.keys
                                                  .map((e) {
                                                final selected =
                                                    selectedIndex ==
                                                        state.statusGroup.keys
                                                            .toList()
                                                            .indexOf(e);
                                                return InkWell(
                                                  onTap: () async {
                                                    if (!selected) {
                                                      setState(() {
                                                        selectedIndex = state
                                                            .statusGroup.keys
                                                            .toList()
                                                            .indexOf(e);
                                                      });
                                                      await prepareOrderBloc
                                                          .loadOrders(
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
                                                        '${e} (${state.statusGroup[e]})',
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
                                                  text: 'Download',
                                                  textColor: kBlack,
                                                  borderColor: kSecondaryColor,
                                                  hasBorder: true,
                                                  onPrimary: kSecondaryColor,
                                                  primary: kSecondaryColor,
                                                  isLoading: state
                                                          .downloadStatus ==
                                                      DownloadStatus.loading,
                                                  onPressed: () async {
                                                    await prepareOrderBloc
                                                        .downloadAwb(
                                                            selectedOrders
                                                                .map<String>(
                                                                    (e) =>
                                                                        e['id'])
                                                                .toList());
                                                  },
                                                ),
                                                // SizedBox(width: 12),
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
                                              if (state.orders?.meta
                                                      ?.totalItems !=
                                                  null)
                                                Text(
                                                  state.orders!.meta!
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
                                                      prepareOrderBloc
                                                          .loadOrders(
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
                                              child: OrderTable(_orders, state),
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

  buildHeader(
    BoxConstraints constraints,
    BuildContext context,
    PrepareOrderState state,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Prepare of orders',
          style: Theme.of(context).textTheme.headline1,
        ),
        Spacings.SMALL_HORIZONTAL,
        searchInput(context),
        Spacings.SMALL_HORIZONTAL,
        // if (constraints.maxWidth > 1000) ...[
        //   dateFilterWidget(context),
        //   Spacings.SMALL_HORIZONTAL,
        //   columnsFilter(context, state),
        // ],
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
                // orderFilter = res;
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
        Button(
          textColor: kWhite,
          primary: kPrimaryColor,
          text: "Start scanning",
          onPressed: () {
            showWhiteDialog(
              context,
              ScanModeDialog(),
              true,
            );
          },
        ),
      ],
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

  search(String? value) {
    prepareOrderBloc.loadOrders(
      OrderFilterParameters(
        page: "1",
        limit: "$perPage",
        searchFilter: value,
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

  OrderTable(List<Map<String, dynamic>>? _orders, PrepareOrderState state) {
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      onSelectAll: (v) => onSelectAll(_orders),
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columns: tableColumns(state),
      rows: tableRows(state),
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

  Widget columnsFilter(BuildContext context, PrepareOrderState state) {
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

  tableColumns(PrepareOrderState state) {
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
              prepareOrderBloc.sortOrders(_sortAscending);
            } else if (index == 7) {
              // status
            }
          });
        },
      );
    });
  }

  tableRows(PrepareOrderState state) {
    List<Map<String, dynamic>>? orders = state.orders?.items ?? [];
    return orders.map((order) {
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
                  ), onTap: () {
                Clipboard.setData(ClipboardData(text: "${order['id']}"));
                showSnackBar(
                  context,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Copied to clipboard"),
                    ],
                  ),
                );
              });
            }
            return DataCell(
              Text(
                "${order[e.name]}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          },
        ).toList(),
      );
    }).toList();
  }

  openEndDrawer(Map<String, dynamic> order) {
    // OrderService.selectedOrder.value = order;
    scaffoldKey.currentState?.openEndDrawer.call();
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context.read<PrepareOrderBloc>().loadOrders(
          OrderFilterParameters(
            page: previous,
            limit: meta.itemsPerPage.toString(),
          ),
        );
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context.read<PrepareOrderBloc>().loadOrders(
          OrderFilterParameters(
            page: next,
            limit: meta.itemsPerPage.toString(),
          ),
        );
  }
}

class ScanModeDialog extends StatelessWidget {
  const ScanModeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Scanning mode", style: Theme.of(context).textTheme.headline3),
          SizedBox(height: 24.0),
          InkWell(
            onTap: () {
              showWhiteDialog(context, ScanModeOrderNumberInputDialog(), true);
            },
            child: Container(
                width: 300,
                padding: EdgeInsets.only(top: 14, bottom: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey3Color),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: Text("Order number"))),
          ),
          // SizedBox(height: 24.0),
          // InkWell(
          //   onTap: () {
          //     showWhiteDialog(context, ScanModeWeightInputDialog(), true);
          //   },
          //   child: Container(
          //       width: 300,
          //       padding: EdgeInsets.only(top: 14, bottom: 14),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: kGrey3Color),
          //         borderRadius: BorderRadius.circular(6),
          //       ),
          //       child: Center(child: Text("Weight input"))),
          // ),
        ],
      ),
    );
  }
}

class ScanModeOrderNumberInputDialog extends StatefulWidget {
  const ScanModeOrderNumberInputDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanModeOrderNumberInputDialog> createState() =>
      _ScanModeOrderNumberInputDialogState();
}

class _ScanModeOrderNumberInputDialogState
    extends State<ScanModeOrderNumberInputDialog> {
  final orderNumberInputController = TextEditingController();
  late PrepareOrderBloc prepareOrderBloc;

  @override
  void initState() {
    prepareOrderBloc = BlocProvider.of<PrepareOrderBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 384.0,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Order number scanning",
              style: Theme.of(context).textTheme.headline3),
          SizedBox(height: 24.0),
          LabeledInput(
            label: "Type in Order number (Or use barcode scanner)",
            controller: orderNumberInputController,
          ),
          CheckboxListTile(
            value: false,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text("Automatically print when scanned"),
            onChanged: (v) {},
          ),
          SizedBox(height: 24.0),
          BlocBuilder<PrepareOrderBloc, PrepareOrderState>(
              builder: (context, state) {
            return Button(
              text: "Print",
              textColor: kWhite,
              isLoading: state.downloadStatus == DownloadStatus.loading,
              primary: kPrimaryColor,
              onPressed: () async {
                if (orderNumberInputController.text.trim().isNotEmpty) {
                  await prepareOrderBloc
                      .downloadAwb([orderNumberInputController.text]);
                }
              },
            );
          }),
        ],
      ),
    );
  }
}

class ScanModeWeightInputDialog extends StatefulWidget {
  const ScanModeWeightInputDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanModeWeightInputDialog> createState() =>
      _ScanModeWeightInputDialogState();
}

class _ScanModeWeightInputDialogState extends State<ScanModeWeightInputDialog> {
  final orderNumberInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    orderNumberInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 384.0,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Weight input scanning",
              style: Theme.of(context).textTheme.headline3),
          SizedBox(height: 24.0),
          LabeledInput(
            label: "Type in Order number (Or use barcode scanner)",
            hintText: "Enter order number and press 'Enter'",
            controller: orderNumberInputController,
            onSubmitted: (v) {
              if (v != null && v.trim().isNotEmpty) {
                showWhiteDialog(context, _WeightInputOrderDetails(v));
              }
            },
          ),
          CheckboxListTile(
            value: false,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text("Automatically print when scanned"),
            onChanged: (v) {},
          ),
          SizedBox(height: 24.0),
          SizedBox(
            width: 70,
            child: Button(
              text: "Print",
              textColor: kWhite,
              primary: kPrimaryColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightInputOrderDetails extends StatelessWidget {
  const _WeightInputOrderDetails(this.orderID, {Key? key}) : super(key: key);

  final String orderID;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 540,
      height: 571,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          Stack(children: [
            SizedBox(
              width: double.infinity,
              child: Center(child: Text("Weight input scanning")),
            ),
            Positioned(
                child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.clear)))
          ]),
          SizedBox(height: 24),
          // Expanded(
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 16,
          //       vertical: 24,
          //     ),
          //     decoration: BoxDecoration(
          //       border: Border.all(color: kPrimaryColor),
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //     child: FutureBuilder<Order>(
          //       future: OrderService.getOrderbyID(orderID),
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           Order order = snapshot.data!;
          //           return Center(child: buildResultUI(context, order));
          //         } else if (snapshot.hasError) {
          //           return Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text("${snapshot.error}"),
          //               SizedBox(height: 12),
          //               TextButton(
          //                   onPressed: () => Navigator.of(context).pop(),
          //                   child: Text("Back")),
          //             ],
          //           );
          //         } else {
          //           return Center(
          //             child: Text("Fetching order details..."),
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  buildResultUI(BuildContext context, Map<String, dynamic> data) {
    return Column(
      children: [
        Row(children: [
          Text(
            "Order No:",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kGrey1Color),
          ),
          SizedBox(width: 8),
          // Text("${data.orderReference?.merchantOrderNumber}",
          //     style: Theme.of(context).textTheme.bodyText1),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Text(
            "Customer name:",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kGrey1Color),
          ),
          SizedBox(width: 8),
          // Text("${data.receiverDetail?.fullname}",
          //     style: Theme.of(context).textTheme.bodyText1),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Text(
            "Address:",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kGrey1Color),
          ),
          SizedBox(width: 8),
          // Text("${data.receiverDetail?.address?.fullAddress}",
          //     style: Theme.of(context).textTheme.bodyText1),
        ]),
        SizedBox(height: 8),
        // if (data.orderPackage != null && data.orderPackage!.isNotEmpty)
        Row(children: [
          Text(
            "Order description:",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: kGrey1Color),
          ),
          SizedBox(width: 8),
          // Text("${data.orderPackage?.first.description}",
          //     style: Theme.of(context).textTheme.bodyText1),
        ]),
      ],
    );
  }
}
