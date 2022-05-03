import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/prepare-orders.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/search_icon.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../orders/manage_order_table/dialogs/filter_dialog.dart';

class PrepareOrdersList extends StatefulWidget {
  static const String routeName = 'prepare-orders';
  const PrepareOrdersList({Key? key}) : super(key: key);

  @override
  _PrepareOrdersListState createState() => _PrepareOrdersListState();
}

class _PrepareOrdersListState extends State<PrepareOrdersList> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late PrepareOrderBloc prepareOrderBloc;
  int sortColumnIndex = 0;
  bool sortAscending = true;

  String? daysFilter;
  String? viewType;
  String? perPage;

  List<String> showTypes = ['All (50)', 'Api (32)', 'Excel(12)', 'Single (6)'];
  int selectedIndex = 0;
  List<Order> selectedOrders = [];

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
      body: Container(
        color: kGrey5Color,
        padding: EdgeInsets.fromLTRB(21, 32, 21, 0),
        child: BlocBuilder<PrepareOrderBloc, PrepareOrderState>(
            bloc: prepareOrderBloc,
            builder: (context, state) {
              var _prepareOrderStatus = state.prepareOrderStatus;
              var _orders = state.orders?.items;
              var _meta = state.orders?.meta;

              if (_prepareOrderStatus == PrepareOrderStatus.loading)
                return const Center(child: CircularProgressIndicator());

              if (_prepareOrderStatus == PrepareOrderStatus.error)
                return TryAgainButton(
                  tryAgain: () async {
                    await prepareOrderBloc.loadOrders();
                  },
                );

              if (_orders != null && _orders.isEmpty)
                return Center(child: Text("No preparing order"));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 34.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text("Prepare Orders",
                            style: Theme.of(context).textTheme.headline1),
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
                              hintText: 'Search by any order parameter',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                    color: kGrey1Color,
                                  ),
                              prefixIcon: SearchIcon(),
                            ),
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
                                ...showTypes.map(
                                  (e) {
                                    final selected =
                                        selectedIndex == showTypes.indexOf(e);
                                    return InkWell(
                                      onTap: () {
                                        if (!selected) {
                                          setState(() {
                                            selectedIndex =
                                                showTypes.indexOf(e);
                                          });
                                        }
                                      },
                                      child: Card(
                                        elevation: 0,
                                        margin: EdgeInsets.zero,
                                        color:
                                            selected ? kSecondaryColor : kWhite,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
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
                                  },
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    if (selectedOrders.isNotEmpty)
                                      Button(
                                        text: 'Download',
                                        textColor: kBlack,
                                        borderColor: kSecondaryColor,
                                        hasBorder: true,
                                        onPrimary: kSecondaryColor,
                                        primary: kSecondaryColor,
                                        isLoading: state.downloadStatus ==
                                            DownloadStatus.loading,
                                        onPressed: () async {
                                          await prepareOrderBloc.downloadAwb(
                                              selectedOrders
                                                  .map((e) => e.id)
                                                  .toList());
                                        },
                                      ),
                                    SizedBox(width: 16.w),
                                    Button(
                                      text: 'Print',
                                    ),
                                  ],
                                ),
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
                                        "${_orders?.length} orders",
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
                                        width: 85,
                                        child: DecoratedDropdown<String>(
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
                                        headingRowColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return kSecondaryColor
                                                  .withOpacity(0.6);
                                            }
                                            return kSecondaryColor;
                                          },
                                        ),
                                        dataRowColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return kGrey5Color;
                                            }
                                            return kWhite;
                                          },
                                        ),
                                        headingTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                        dataTextStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        columnSpacing: 36.w,
                                        horizontalMargin: 12.w,
                                        dividerThickness: 0.4.sp,
                                        headingRowHeight: 58.h,
                                        onSelectAll: (value) {
                                          setState(() {
                                            if (selectedOrders.isEmpty &&
                                                state.orders != null &&
                                                state.orders!.items != null) {
                                              selectedOrders
                                                  .addAll(state.orders!.items!);
                                            } else if (selectedOrders
                                                    .isNotEmpty &&
                                                state.orders != null &&
                                                state.orders!.items != null) {
                                              selectedOrders = [];
                                            }
                                          });
                                        },
                                        sortColumnIndex: sortColumnIndex,
                                        sortAscending: sortAscending,
                                        columns: this.tableColumns,
                                        rows: tableRows(state),
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
            }),
      ),
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

  tableRows(PrepareOrderState state) {
    List<Order>? orders = prepareOrderBloc.state.orders?.items;
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
        cells: <DataCell>[
          DataCell(Text("${order.orderReference?.merchantOrderNumber}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.merchant?.companyName}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.allowWeekendDelivery}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryAmount}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryCurrency}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.cashOnDeliveryRequested}"),
              onTap: () => openEndDrawer(order)),
          DataCell(Text("${order.createdAt}"),
              onTap: () => openEndDrawer(order)),
          DataCell(statusBall(order.status, false),
              onTap: () => openEndDrawer(order)),
        ],
      );
    }).toList();
  }

  openEndDrawer(Order order) {
    OrderService.selectedOrder.value = order;
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
          SizedBox(height: 24.0),
          InkWell(
            onTap: () {
              showWhiteDialog(context, ScanModeWeightInputDialog(), true);
            },
            child: Container(
                width: 300,
                padding: EdgeInsets.only(top: 14, bottom: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: kGrey3Color),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: Text("Weight input"))),
          ),
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
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(6),
              ),
              child: FutureBuilder<Order>(
                future: OrderService.getOrderbyID(orderID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Order order = snapshot.data!;
                    return Center(child: buildResultUI(context, order));
                  } else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${snapshot.error}"),
                        SizedBox(height: 12),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Back")),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("Fetching order details..."),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildResultUI(BuildContext context, Order data) {
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
          Text("${data.orderReference?.merchantOrderNumber}",
              style: Theme.of(context).textTheme.bodyText1),
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
          Text("${data.receiverDetail?.fullname}",
              style: Theme.of(context).textTheme.bodyText1),
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
          Text("${data.receiverDetail?.address?.fullAddress}",
              style: Theme.of(context).textTheme.bodyText1),
        ]),
        SizedBox(height: 8),
        if (data.orderPackage != null && data.orderPackage!.isNotEmpty)
          Row(children: [
            Text(
              "Order description:",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: kGrey1Color),
            ),
            SizedBox(width: 8),
            Text("${data.orderPackage?.first.description}",
                style: Theme.of(context).textTheme.bodyText1),
          ]),
      ],
    );
  }
}
