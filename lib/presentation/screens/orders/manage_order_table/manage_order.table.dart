import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow_list/flow_bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../../data/enums/status.enum.dart';
import '../../../../data/services/app.service.dart';
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

  int sortColumnIndex = 0;
  bool sortAscending = true;

  String? viewType;
  String? perPage;

  List<String> showTypes = [
    'All (50)',
    'Pickup (32)',
    'Transit(12)',
    'Delivery (6)'
  ];
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
                                      color:
                                          selected ? kSecondaryColor : kWhite,
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
                                if (selectedOrders.isNotEmpty) Spacer(),
                                if (selectedOrders.isNotEmpty)
                                  Button(
                                    primary: kWhite,
                                    textColor: kPrimaryColor,
                                    isLoading:
                                        orderState.deleteMultipleOrderStatus ==
                                            DeleteMultipleOrderStatus.loading,
                                    text:
                                        "Delete orders ${selectedOrders.length}",
                                    onPressed: () async {
                                      await orderBloc.deleteOrders(
                                          selectedOrders
                                              .map((Order e) => e.id)
                                              .toList());
                                      setState(() {
                                        selectedOrders = [];
                                      });
                                    },
                                  ),
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
                                            print(
                                                OrderService.currentPage.value);
                                            if (OrderService
                                                    .currentPage.value !=
                                                null) {
                                              orderBloc.loadOrders(
                                                  page: OrderService
                                                      .currentPage.value!,
                                                  limit: v);
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
                                        headingRowColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (states) {
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
                                          (states) {
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
                prefixIcon: Container(
                  padding: EdgeInsets.all(10.sp),
                  child: AppIcons.svgAsset(AppIcons.search),
                ),
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
          if (AppService.hasPermission(PermissionType.CREATE_ORDER))
            Spacings.SMALL_HORIZONTAL,
          if (AppService.hasPermission(PermissionType.CREATE_ORDER))
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                "Add new order",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: kWhite),
              ),
              onPressed: () => addNewOrderTapped(context),
            ),
        ],
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

  tableRows(OrderState state) {
    List<Order>? orders = orderBloc.state.orders?.items;
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

  addNewOrderTapped(BuildContext context) {
    showWhiteDialog(context, UploadViewModal());
  }

  loadPrevious(Meta? meta) async {
    var previous = (meta!.currentPage - 1).toString();
    await context
        .read<OrderBloc>()
        .loadOrders(page: previous, limit: meta.itemsPerPage.toString());
  }

  loadNext(Meta? meta) async {
    var next = (meta!.currentPage + 1).toString();
    await context
        .read<OrderBloc>()
        .loadOrders(page: next, limit: meta.itemsPerPage.toString());
  }

  search(String? value) {
    orderBloc.loadOrders(
      page: "1",
      limit: perPage,
      searchFilter: value,
    );
  }

  buildSubmitValueWidget(OrderFilterType filterType) {
    switch (filterType) {
      case OrderFilterType.startDate:
        // date
        return;
      case OrderFilterType.endDate:
        // date selector
        return;
      case OrderFilterType.specificFilterStatus:
        // dropdown
        return DropdownButton(
          onChanged: (v) {},
          items: [1, 2, 3, 4]
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text("$e"),
                  ))
              .toList(),
        );
      case OrderFilterType.specificFilterTenantId:
        // input field
        return;
      case OrderFilterType.specificFilterMerchantId:
        // input field
        return;
      case OrderFilterType.specificFilterCreatedById:
        // input field
        return;
      case OrderFilterType.specificFilterWorkflowId:
        // dropdown (select one of the workflows and get its id)
        return;
      case OrderFilterType.specificFilterServiceType:
        // dropdown
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              value: false,
              groupValue: false,
              onChanged: (v) {},
              title: Text("Title 1"),
            ),
            RadioListTile(
              value: false,
              groupValue: false,
              onChanged: (v) {},
              title: Text("Title 2"),
            ),
            RadioListTile(
              value: false,
              groupValue: false,
              onChanged: (v) {},
              title: Text("Title 3"),
            ),
          ],
        );
      case OrderFilterType.specificFilterServiceLevel:
        // dropdown
        return;
      case OrderFilterType.specificFilterDeliveryDateBasedOnUpload:
        // date selector
        return;
      case OrderFilterType.specificFilterDeliveryDateBasedOnPickUp:
        // date selector
        return;
      case OrderFilterType.specificFilterAllowWeekendDelivery:
        // dropdown (yes/no/not specify)
        return;
      case OrderFilterType.specificFilterPickUpRequested:
        // dropdown (yes/no/not specify)
        return;
      case OrderFilterType.specificFilterRequestedDeliveryTimeSlotType:
        // dropdown
        return;
      case OrderFilterType.specificFilterRequestedDeliveryTimeSlotStart:
        // date selector
        return;
      case OrderFilterType.specificFilterRequestedDeliveryTimeSlotEnd:
        // date selector
        return;
      case OrderFilterType.specificFilterCashOnDeliveryRequested:
        // dropdown (yes/no/not specify)
        return;
      case OrderFilterType.specificFilterCashOnDeliveryAmount:
        // numeric input field
        return;
      case OrderFilterType.specificFilterCashOnDeliveryCurrency:
        // input field or dropdown (if currencies predefined)
        return;
      case OrderFilterType.specificFilterInsuredAmount:
        // numeric input field
        return;
      case OrderFilterType.specificFilterInsuredAmountCurrency:
        // input field or dropdown (if currencies predefined)
        return;
      default:
        return SizedBox();
    }
  }
}

class OrderFilterMenu extends StatefulWidget {
  const OrderFilterMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderFilterMenu> createState() => _OrderFilterMenuState();
}

class _OrderFilterMenuState extends State<OrderFilterMenu> {
  late WorkflowBloc workflowBloc;
  late MerchantBloc merchantBloc;

  DateTime? startDate;

  DateTime? endDate;

  Status? specificFilterStatus;

  String? specificFilterTenantId;

  String? specificFilterMerchantId;

  String? specificFilterCreatedById;

  String? specificFilterWorkflowId;

  ServiceType? specificFilterServiceType;

  ServiceLevel? specificFilterServiceLevel;

  DateTime? specificFilterDeliveryDateBasedOnUpload;

  DateTime? specificFilterDeliveryDateBasedOnPickUp;

  bool? specificFilterAllowWeekendDelivery;

  bool? specificFilterPickUpRequested;

  DeliveryTimeSlotType? specificFilterRequestedDeliveryTimeSlotType;
  DateTime? specificFilterRequestedDeliveryTimeSlotStart;
  DateTime? specificFilterRequestedDeliveryTimeSlotEnd;

  bool? specificFilterCashOnDeliveryRequested;

  int? specificFilterCashOnDeliveryAmount;

  String? specificFilterCashOnDeliveryCurrency;

  int? specificFilterInsuredAmount;

  String? specificFilterInsuredAmountCurrency;

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    merchantBloc = BlocProvider.of<MerchantBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 320.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              contentPadding: EdgeInsets.zero,
              style: ListTileStyle.drawer,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 32.0,
                    bottom: 20,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("More filters",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      FilterStartDate(context),
                      FilterEndDate(context),
                      FilterStatus(context),
                      FilterTenant(context),
                      FilterMerchant(context),
                      FilterCreatedBy(context),
                      FilterWorkflow(context),
                      FilterServiceType(context),
                      FilterServiceLevel(context),
                      FilterDeliveryDateUpload(context),
                      FilterDeliveryDatePickup(context),
                      FilterAllowWeekend(context),
                      FilterRequestedDeliveryTimeSlotType(context),
                      FilterRequestedTimeSlotStart(context),
                      FilterRequestedTimeSlotEnd(context),
                      FilterCODRequested(context),
                      FilterCODAmount(context),
                      FilterCODCurrency(context),
                      FilterInsuredAmount(context),
                      FilterInsuredAmountCurrency(context),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 12.0,
                  bottom: 20,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(primary: kGrey1Color),
                      child: Text("Clear filters"),
                      onPressed: () {},
                    ),
                    Button(
                      textColor: kWhite,
                      hasBorder: false,
                      primary: kPrimaryColor,
                      text: "Apply filter",
                      isLoading: false,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FilterInsuredAmountCurrency(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Insured Amount Currency",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterInsuredAmount(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Insured Amount",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterCODCurrency(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Cash on Delivery Currency",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterCODAmount(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Cash on Delivery Amount",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterCODRequested(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Cash on Delivery Requested",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterRequestedTimeSlotEnd(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Requested Delivery Time Slot End",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterRequestedTimeSlotStart(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Requested Delivery Time Slot Start",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterRequestedDeliveryTimeSlotType(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Requested Delivery Time Slot Type",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterAllowWeekend(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Allow Weekend Delivery",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterDeliveryDatePickup(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Delivery Date Based on Pickup",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterDeliveryDateUpload(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Delivery Date Based on Upload",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterServiceLevel(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Service level",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterServiceType(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Service type",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterCreatedBy(BuildContext context) {
    return ExpansionTile(
        title: Text(
          "Created by",
          style: Theme.of(context).textTheme.headline3,
        ),
        children: []);
  }

  FilterMerchant(BuildContext context) {
    return BlocBuilder<MerchantBloc, MerchantState>(builder: (context, state) {
      return ExpansionTile(
        title: Text(
          "Merchant",
          style: Theme.of(context).textTheme.headline3,
        ),
        onExpansionChanged: (v) {
          if (v && state.merchants == null) {
            merchantBloc.loadMerchants();
          }
        },
        children: [
          if (state.listMerchantStatus == ListMerchantStatus.loading)
            const Center(child: CircularProgressIndicator()),
          if (state.merchants != null)
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: specificFilterWorkflowId,
                onChanged: (v) {
                  setState(() {
                    specificFilterWorkflowId = v;
                  });
                },
                items: state.merchants?.items?.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.id,
                    child: Text(e.fullname),
                  );
                }).toList(),
              ),
            ),
          if (state.listMerchantStatus != ListMerchantStatus.loading &&
              state.merchants == null)
            Center(child: Text("Error while fetching merchants")),
        ],
      );
    });
  }

  FilterTenant(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Tenant",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [],
    );
  }

  FilterEndDate(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "End date",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: endDate ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                endDate = res;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 34,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kGrey5Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (endDate != null)
                  Expanded(child: Text(DateHelper.yyyyMMdd(endDate!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
      ],
    );
  }

  FilterStartDate(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Start date",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: startDate ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                startDate = res;
              });
            }
          },
          child: Container(
            width: double.infinity,
            height: 34,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: kGrey5Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (startDate != null)
                  Expanded(child: Text(DateHelper.yyyyMMdd(startDate!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
      ],
    );
  }

  FilterWorkflow(BuildContext context) {
    return BlocBuilder<WorkflowBloc, WorkflowState>(
        bloc: workflowBloc,
        builder: (context, state) {
          return ExpansionTile(
            title: Text(
              "Workflow",
              style: Theme.of(context).textTheme.headline3,
            ),
            onExpansionChanged: (v) {
              if (v && state.workflows == null) {
                workflowBloc.loadWorkflows();
              }
            },
            children: [
              if (state.flowListStatus == FlowListStatus.loading)
                const Center(child: CircularProgressIndicator()),
              if (state.workflows != null)
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: specificFilterWorkflowId,
                    onChanged: (v) {
                      setState(() {
                        specificFilterWorkflowId = v;
                      });
                    },
                    items: state.workflows!.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name ?? e.description ?? ""),
                      );
                    }).toList(),
                  ),
                ),
              if (state.workflows == null &&
                  state.flowListStatus != FlowListStatus.loading)
                Center(child: Text("Error while fetching workflows")),
            ],
          );
        });
  }

  FilterStatus(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Status",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: SingleChildScrollView(
            child: Column(
              children: [Status.ORDER_CREATED]
                  .map((e) => RadioListTile<Status>(
                        value: e,
                        groupValue: specificFilterStatus,
                        onChanged: (v) {
                          setState(() {
                            specificFilterStatus = v;
                          });
                        },
                        selected: e == specificFilterStatus,
                        title: Text(e.text),
                        contentPadding: EdgeInsets.zero,
                      ))
                  .toList(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: TextButton(
              onPressed: () {
                setState(() {
                  specificFilterStatus = null;
                });
              },
              child: Text("Clear")),
        ),
      ],
    );
  }
}

/// no need to use this after all, must create new fully customized
/// dropdown like card and display it using stack & positioned
class DecoratedDropdown extends StatelessWidget {
  const DecoratedDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  final value;
  final items;
  final icon;
  final void Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
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
                    padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                    child: icon,
                  ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              items: items.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    '$e',
                    style: Theme.of(context).textTheme.bodyText1,
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
