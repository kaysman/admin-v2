import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/manage_order.table.dart';
import 'package:lng_adminapp/presentation/screens/prepare-orders/prepare-orders.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/presentation/shared/components/status-indicator.widget.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  List<DataColumn> tableColumns = [
    DataColumn(label: Text("Order #")),
    DataColumn(label: Text("Description")),
    DataColumn(label: Text("Quantity")),
    DataColumn(label: Text("Weight")),
    DataColumn(label: Text("Pickup date")),
    DataColumn(label: Text("Delivery date")),
    DataColumn(label: Text("Upload method")),
    DataColumn(label: Text("Upload date")),
    DataColumn(label: Text("SL status")),
  ];
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
                              prefixIcon: Container(
                                padding: EdgeInsets.all(10.sp),
                                child: AppIcons.svgAsset(AppIcons.search),
                              ),
                            ),
                          ),
                        ),
                        Spacings.SMALL_HORIZONTAL,
                        SizedBox(
                          width: 160,
                          child: DecoratedDropdown(
                            value: daysFilter,
                            icon: AppIcons.svgAsset(AppIcons.calendar),
                            items: [
                              'Past 1 day',
                              'Past 1 week',
                              'Past 1 month'
                            ],
                            onChanged: (v) {
                              setState(() => daysFilter = v);
                            },
                          ),
                        ),
                        Spacings.SMALL_HORIZONTAL,
                        SizedBox(
                          width: 160,
                          child: DecoratedDropdown(
                            value: viewType,
                            icon: AppIcons.svgAsset(AppIcons.columns),
                            items: ['Columns', 'Rows'],
                            onChanged: (v) {
                              setState(() => viewType = v);
                            },
                          ),
                        ),
                        Spacer(),
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
                                        await prepareOrderBloc
                                            .downloadAwb(selectedOrders);
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
                                        // onSelectAll: (value) {
                                        //   // selectedOrders.addAll(
                                        //   //     state.orders!.items!.toList());
                                        //   print(
                                        //       '$value >>>> this is the value');
                                        // },
                                        sortColumnIndex: sortColumnIndex,
                                        sortAscending: sortAscending,
                                        columns: this.tableColumns,
                                        rows: this.tableRows,
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

  get tableRows {
    return [];
    // List<Order>? orders = prepareOrderBloc.state.orders?.items;
    // return List.generate(orders!.length, (index) {
    //   var order = orders[index];
    //   return DataRow(
    //     color: MaterialStateProperty.resolveWith<Color?>(
    //         (Set<MaterialState> states) {
    //       if (states.contains(MaterialState.selected)) {
    //         return kPrimaryColor.withOpacity(0.08);
    //       }
    //       if (states.contains(MaterialState.hovered)) {
    //         return kGrey5Color;
    //       }
    //       return null;
    //     }),
    //     onSelectChanged: (v) {
    //       setState(() {
    //         final isAdding = v != null && v;

    //         isAdding ? selectedOrders.add(order) : selectedOrders.remove(order);
    //       });
    //       // OrderService.selectedOrder.value = order;
    //       // scaffoldKey.currentState?.openEndDrawer.call();
    //     },
    //     selected: selectedOrders.contains(order),
    //     cells: <DataCell>[
    //       DataCell(Text("${order.orderNumber}")),
    //       DataCell(Text("${order.description}")),
    //       DataCell(Text("${order.quantity}")),
    //       DataCell(Text("${order.weight}")),
    //       DataCell(Text("${order.pickupDate}")),
    //       DataCell(Text("${order.deliveryDate}")),
    //       DataCell(Text("-")),
    //       DataCell(Text("${order.createdAt}")),
    //       DataCell(
    //         order.status == Status.ORDER_CREATED.name
    //             ? StatusIndicator(
    //                 isBold: false,
    //                 color: kInprogressColor,
    //                 label: 'Not Printed',
    //               )
    //             : StatusIndicator(
    //                 isBold: false,
    //                 color: kSuccessColor,
    //                 label: 'Printed',
    //               ),
    //       ),
    //     ],
    //   );
    // });
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    print(previous);
    await context
        .read<PrepareOrderBloc>()
        .loadOrders(previous, meta.itemsPerPage.toString());
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    print(next);
    await context
        .read<PrepareOrderBloc>()
        .loadOrders(next, meta.itemsPerPage.toString());
  }
}
