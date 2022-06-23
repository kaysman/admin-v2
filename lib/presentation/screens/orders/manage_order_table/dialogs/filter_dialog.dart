import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/data/services/user.service.dart';
import 'package:lng_adminapp/presentation/blocs/enum_handling.bloc.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import '../../../../shared/components/assign.dialog.dart';
import '../../../operational_flow/flow_bloc.dart';

enum _DateFields {
  deliveryDateBasedOnUpload,
  deliveryDateBasedOnPickUp,
  requestedDeliveryTimeSlotStart,
  requestedDeliveryTimeSlotEnd
}

class OrderFilterMenu extends StatefulWidget {
  const OrderFilterMenu({Key? key, this.filters}) : super(key: key);

  final OrderFilterParameters? filters;

  @override
  State<OrderFilterMenu> createState() => _OrderFilterMenuState();
}

class _OrderFilterMenuState extends State<OrderFilterMenu> {
  UserList? merchantList;

  late WorkflowBloc workflowBloc;
  late MerchantBloc merchantBloc;
  late OrderBloc orderBloc;
  late EnumHandlingBloc enumHandlingBloc;

  String? specificFilterStatus;
  clearFilterStatus() {
    setState(() {
      specificFilterStatus = null;
    });
  }

  String? specificFilterMerchantId;
  clearFilterMerchantID() {
    setState(() {
      specificFilterMerchantId = null;
    });
  }

  String? specificFilterCreatedById;
  clearFilterCreatedById() {
    setState(() {
      specificFilterCreatedById = null;
    });
  }

  String? specificFilterWorkflowId;
  clearFilterWorkflowID() {
    setState(() {
      specificFilterWorkflowId = null;
    });
  }

  String? specificFilterServiceType;
  clearFilterServiceType() {
    setState(() {
      specificFilterServiceType = null;
    });
  }

  String? specificFilterServiceLevel;
  clearFilterServiceLevel() {
    setState(() {
      specificFilterServiceLevel = null;
    });
  }

  DateTime? specificFilterDeliveryDateBasedOnUpload;
  clearFilterDeliveryDateBasedOnUpload() {
    setState(() {
      specificFilterDeliveryDateBasedOnUpload = null;
    });
  }

  DateTime? specificFilterDeliveryDateBasedOnPickUp;
  clearFilterDeliveryDateBasedOnPickUp() {
    setState(() {
      specificFilterDeliveryDateBasedOnPickUp = null;
    });
  }

  bool? specificFilterAllowWeekendDelivery;
  clearFilterAllowWeekendDelivery() {
    setState(() {
      specificFilterAllowWeekendDelivery = null;
    });
  }

  bool? specificFilterPickUpRequested;
  clearFilterPickUpRequested() {
    setState(() {
      specificFilterPickUpRequested = null;
    });
  }

  String? specificFilterRequestedDeliveryTimeSlotType;
  clearFilterRequestedDeliveryTimeSlotType() {
    setState(() {
      specificFilterRequestedDeliveryTimeSlotType = null;
    });
  }

  DateTime? specificFilterRequestedDeliveryTimeSlotStart;
  clearFilterRequestedDeliveryTimeSlotStart() {
    setState(() {
      specificFilterRequestedDeliveryTimeSlotStart = null;
    });
  }

  DateTime? specificFilterRequestedDeliveryTimeSlotEnd;
  clearFilterRequestedDeliveryTimeSlotEnd() {
    setState(() {
      specificFilterRequestedDeliveryTimeSlotEnd = null;
    });
  }

  bool? specificFilterCashOnDeliveryRequested;
  clearFilterCashOnDeliveryRequested() {
    setState(() {
      specificFilterCashOnDeliveryRequested = null;
    });
  }

  final codAmountController = TextEditingController();
  clearFilterCashOnDeliveryAmount() {
    setState(() {
      codAmountController.clear();
    });
  }

  final specificFilterCashOnDeliveryCurrency = TextEditingController();
  clearFilterCashOnDeliveryCurrency() {
    setState(() {
      specificFilterCashOnDeliveryCurrency.clear();
    });
  }

  final insuredAmountController = TextEditingController();
  clearFilterInsuredAmount() {
    setState(() {
      insuredAmountController.clear();
    });
  }

  final specificFilterInsuredAmountCurrency = TextEditingController();
  clearFilterInsuredAmountCurrency() {
    setState(() {
      specificFilterInsuredAmountCurrency.clear();
    });
  }

  clearAllFilters() {
    setState(() {
      specificFilterStatus = null;
      specificFilterMerchantId = null;
      specificFilterCreatedById = null;
      specificFilterWorkflowId = null;
      specificFilterServiceType = null;
      specificFilterServiceLevel = null;
      specificFilterDeliveryDateBasedOnUpload = null;
      specificFilterDeliveryDateBasedOnPickUp = null;
      specificFilterAllowWeekendDelivery = false;
      specificFilterPickUpRequested = null;
      specificFilterRequestedDeliveryTimeSlotType = null;
      specificFilterRequestedDeliveryTimeSlotStart = null;
      specificFilterRequestedDeliveryTimeSlotEnd = null;
      specificFilterCashOnDeliveryRequested = false;
      codAmountController.text = "";
      specificFilterCashOnDeliveryCurrency.text = "";
      insuredAmountController.text = "";
      specificFilterInsuredAmountCurrency.text = "";
    });
  }

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    merchantBloc = BlocProvider.of<MerchantBloc>(context);
    getMerchants();
    orderBloc = BlocProvider.of<OrderBloc>(context);
    enumHandlingBloc = BlocProvider.of<EnumHandlingBloc>(context);
    super.initState();
  }

  getMerchants() async {
    merchantList = await UserService.fetchMerchantsWithoutPagination();
  }

  // checkFiltersExistence() {
  //   var filters = widget.filters;
  //   if (filters != null) {
  //     setState(() {
  //       startDate = DateTime.tryParse(filters.startDate ?? '');
  //       endDate = DateTime.tryParse(filters.endDate ?? '');
  //       specificFilterStatus = filters.specificFilterStatus;
  //       specificFilterTenantId = null;
  //       specificFilterMerchantId = null;
  //       specificFilterCreatedById = null;
  //       specificFilterWorkflowId = null;
  //       specificFilterServiceType = null;
  //       specificFilterServiceLevel = null;
  //       specificFilterDeliveryDateBasedOnUpload = null;
  //       specificFilterDeliveryDateBasedOnPickUp = null;
  //       specificFilterAllowWeekendDelivery = false;
  //       specificFilterPickUpRequested = null;
  //       specificFilterRequestedDeliveryTimeSlotType = null;
  //       specificFilterRequestedDeliveryTimeSlotStart = null;
  //       specificFilterRequestedDeliveryTimeSlotEnd = null;
  //       specificFilterCashOnDeliveryRequested = null;
  //       codAmountController.text = "";
  //       specificFilterCashOnDeliveryCurrency = null;
  //       insuredAmountController.text = "";
  //       specificFilterInsuredAmountCurrency = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 375.0,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        bottom: 10,
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("More filters",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          children: [
                            FilterStatus(context),
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
                  ],
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
                      onPressed: clearAllFilters,
                    ),
                    BlocConsumer<OrderBloc, OrderState>(
                      listenWhen: (state1, state2) =>
                          state1.orderStatus != state2.orderStatus,
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Button(
                          textColor: kWhite,
                          hasBorder: false,
                          primary: kPrimaryColor,
                          text: "Apply filter",
                          isLoading: state.orderStatus == OrderStatus.loading,
                          onPressed: () async {
                            try {
                              var filterParams = OrderFilterParameters(
                                page: OrderService.currentPage.value,
                                limit: "10",
                                specificFilterStatus: specificFilterStatus,
                                specificFilterMerchantId:
                                    specificFilterMerchantId,
                                specificFilterCreatedById:
                                    specificFilterCreatedById,
                                specificFilterWorkflowId:
                                    specificFilterWorkflowId,
                                specificFilterServiceType:
                                    specificFilterServiceType,
                                specificFilterServiceLevel:
                                    specificFilterServiceLevel,
                                specificFilterDeliveryDateBasedOnUpload:
                                    specificFilterDeliveryDateBasedOnUpload !=
                                            null
                                        ? specificFilterDeliveryDateBasedOnUpload!
                                            .toIso8601String()
                                        : null,
                                specificFilterDeliveryDateBasedOnPickUp:
                                    specificFilterDeliveryDateBasedOnPickUp !=
                                            null
                                        ? specificFilterDeliveryDateBasedOnPickUp!
                                            .toIso8601String()
                                        : null,
                                specificFilterAllowWeekendDelivery:
                                    specificFilterAllowWeekendDelivery,
                                specificFilterPickUpRequested:
                                    specificFilterPickUpRequested,
                                specificFilterRequestedDeliveryTimeSlotType:
                                    specificFilterRequestedDeliveryTimeSlotType,
                                specificFilterRequestedDeliveryTimeSlotStart:
                                    specificFilterRequestedDeliveryTimeSlotStart !=
                                            null
                                        ? specificFilterRequestedDeliveryTimeSlotStart!
                                            .toIso8601String()
                                        : null,
                                specificFilterRequestedDeliveryTimeSlotEnd:
                                    specificFilterRequestedDeliveryTimeSlotEnd !=
                                            null
                                        ? specificFilterRequestedDeliveryTimeSlotEnd!
                                            .toIso8601String()
                                        : null,
                                specificFilterCashOnDeliveryRequested:
                                    specificFilterCashOnDeliveryRequested,
                                specificFilterCashOnDeliveryAmount:
                                    int.tryParse(codAmountController.text),
                                specificFilterCashOnDeliveryCurrency:
                                    specificFilterCashOnDeliveryCurrency.text
                                            .trim()
                                            .isEmpty
                                        ? null
                                        : specificFilterCashOnDeliveryCurrency
                                            .text,
                                specificFilterInsuredAmount:
                                    int.tryParse(insuredAmountController.text),
                                specificFilterInsuredAmountCurrency:
                                    specificFilterInsuredAmountCurrency.text
                                            .trim()
                                            .isEmpty
                                        ? null
                                        : specificFilterInsuredAmountCurrency
                                            .text,
                              );
                              await orderBloc.loadOrders(filterParams);
                              Navigator.of(context).pop(filterParams);
                            } catch (_) {}
                          },
                        );
                      },
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
      children: [
        TextFormField(controller: specificFilterInsuredAmountCurrency),
        ClearButton(clearFilterInsuredAmountCurrency),
      ],
    );
  }

  FilterInsuredAmount(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Insured Amount",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        TextFormField(
          controller: insuredAmountController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ClearButton(clearFilterInsuredAmount),
      ],
    );
  }

  FilterCODCurrency(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Cash on Delivery Currency",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        TextFormField(controller: specificFilterCashOnDeliveryCurrency),
        ClearButton(clearFilterCashOnDeliveryCurrency),
      ],
    );
  }

  FilterCODAmount(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Cash on Delivery Amount",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        TextFormField(
          controller: codAmountController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        ClearButton(clearFilterCashOnDeliveryAmount),
      ],
    );
  }

  FilterCODRequested(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Cash on Delivery Requested",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        CheckboxListTile(
          value: specificFilterCashOnDeliveryRequested,
          tristate: true,
          onChanged: (v) {
            setState(() {
              specificFilterCashOnDeliveryRequested = v!;
            });
          },
          title: Text(
            "Cash on Delivery Requested?",
            style: Theme.of(context).textTheme.headline4,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        ClearButton(clearFilterCashOnDeliveryRequested),
      ],
    );
  }

  FilterRequestedTimeSlotEnd(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Requested Delivery Time Slot End",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () => onTimeChanged(
            context,
            specificFilterRequestedDeliveryTimeSlotEnd,
            _DateFields.requestedDeliveryTimeSlotEnd,
          ),
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
                if (specificFilterRequestedDeliveryTimeSlotEnd != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterRequestedDeliveryTimeSlotEnd!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(clearFilterRequestedDeliveryTimeSlotEnd),
      ],
    );
  }

  FilterRequestedTimeSlotStart(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Requested Delivery Time Slot Start",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () => onTimeChanged(
            context,
            specificFilterRequestedDeliveryTimeSlotStart,
            _DateFields.requestedDeliveryTimeSlotStart,
          ),
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
                if (specificFilterRequestedDeliveryTimeSlotStart != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterRequestedDeliveryTimeSlotStart!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(clearFilterRequestedDeliveryTimeSlotStart),
      ],
    );
  }

  FilterRequestedDeliveryTimeSlotType(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Requested Delivery Time Slot Type",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
          builder: (context, state) {
            var key = EnumType.DELIVERY_TIME_SLOT_TYPE.name;

            if (state.status == EnumHandlingStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == EnumHandlingStatus.error) {
              return TryAgainButton(
                tryAgain: () => enumHandlingBloc.loadEnumsByType(key),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.enums[key] != null)
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width * 0.22,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: state.enums[key]!
                              .map(
                                (e) => RadioListTile<String>(
                                  value: e,
                                  groupValue:
                                      specificFilterRequestedDeliveryTimeSlotType,
                                  onChanged: (v) {
                                    setState(() {
                                      specificFilterRequestedDeliveryTimeSlotType =
                                          v;
                                    });
                                  },
                                  selected: e ==
                                      specificFilterRequestedDeliveryTimeSlotType,
                                  title: Text(e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ClearButton(clearFilterRequestedDeliveryTimeSlotType),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  FilterAllowWeekend(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Allow Weekend Delivery",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        CheckboxListTile(
          value: specificFilterAllowWeekendDelivery,
          tristate: true,
          onChanged: (v) {
            setState(() {
              specificFilterAllowWeekendDelivery = v;
            });
          },
          title: Text(
            "Allowing weekend delivery?",
            style: Theme.of(context).textTheme.headline4,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        ClearButton(clearFilterAllowWeekendDelivery),
      ],
    );
  }

  FilterDeliveryDatePickup(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Delivery Date Based on Pickup",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () => onTimeChanged(
            context,
            specificFilterDeliveryDateBasedOnPickUp,
            _DateFields.deliveryDateBasedOnPickUp,
          ),
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
                if (specificFilterDeliveryDateBasedOnPickUp != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterDeliveryDateBasedOnPickUp!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(clearFilterDeliveryDateBasedOnPickUp),
      ],
    );
  }

  FilterDeliveryDateUpload(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Delivery Date Based on Upload",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        InkWell(
          onTap: () => onTimeChanged(
            context,
            specificFilterDeliveryDateBasedOnUpload,
            _DateFields.deliveryDateBasedOnUpload,
          ),
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
                if (specificFilterDeliveryDateBasedOnUpload != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterDeliveryDateBasedOnUpload!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        ClearButton(clearFilterDeliveryDateBasedOnUpload),
      ],
    );
  }

  FilterServiceLevel(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Service level",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
          builder: (context, state) {
            if (state.status == EnumHandlingStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == EnumHandlingStatus.error) {
              return TryAgainButton(
                tryAgain: () => enumHandlingBloc
                    .loadEnumsByType(EnumType.SERVICE_LEVEL.name),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.enums[EnumType.SERVICE_LEVEL.name] != null)
                    ...state.enums[EnumType.SERVICE_LEVEL.name]!.map(
                      (e) => RadioListTile<String>(
                        value: e,
                        groupValue: specificFilterServiceLevel,
                        onChanged: (v) {
                          setState(() {
                            specificFilterServiceLevel = v;
                          });
                        },
                        selected: e == specificFilterServiceLevel,
                        title: Text(e,
                            style: Theme.of(context).textTheme.bodyText1),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ClearButton(clearFilterServiceType),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  FilterServiceType(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Service type",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
          builder: (context, state) {
            if (state.status == EnumHandlingStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == EnumHandlingStatus.error) {
              return TryAgainButton(
                tryAgain: () => enumHandlingBloc
                    .loadEnumsByType(EnumType.SERVICE_TYPE.name),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.enums[EnumType.SERVICE_TYPE.name] != null)
                    ...state.enums[EnumType.SERVICE_TYPE.name]!.map(
                      (e) => RadioListTile<String>(
                        value: e,
                        groupValue: specificFilterServiceType,
                        onChanged: (v) {
                          setState(() {
                            specificFilterServiceType = v;
                          });
                        },
                        selected: e == specificFilterServiceType,
                        title: Text(e,
                            style: Theme.of(context).textTheme.bodyText1),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ClearButton(clearFilterServiceType),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  FilterCreatedBy(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Created by (Merchant)",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        if (merchantList == null) ...[
          Center(child: Text("Fetching merchants")),
          SizedBox(height: 14),
        ],
        if (merchantList != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: specificFilterCreatedById,
                  onChanged: (v) {
                    setState(() {
                      specificFilterCreatedById = v;
                    });
                  },
                  items: merchantList!.items?.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.fullname),
                    );
                  }).toList(),
                ),
              ),
              ClearButton(clearFilterStatus),
            ],
          ),
      ],
    );
  }

  FilterMerchant(BuildContext context) {
    return BlocConsumer<MerchantBloc, MerchantState>(
      listenWhen: (state1, state2) =>
          state1.merchants != state2.merchants ||
          state1.listMerchantStatus != state2.listMerchantStatus,
      listener: (context, state) {},
      builder: (context, state) {
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
              SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Center(child: Text("Fetching..."))),
            if (state.merchants != null) ...[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: specificFilterMerchantId,
                  onChanged: (v) {
                    setState(() {
                      specificFilterMerchantId = v;
                    });
                  },
                  items: state.merchants!.items?.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.fullname),
                    );
                  }).toList(),
                ),
              ),
              ClearButton(clearFilterMerchantID)
            ],
            if (state.listMerchantStatus != ListMerchantStatus.loading &&
                state.merchants == null)
              Center(child: Text("Error while fetching merchants")),
          ],
        );
      },
    );
  }

  FilterWorkflow(BuildContext context) {
    return BlocConsumer<WorkflowBloc, WorkflowState>(
      listenWhen: (state1, state2) =>
          state1.workflows != state2.workflows ||
          state1.flowListStatus != state2.flowListStatus,
      listener: (context, state) {},
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
              SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Center(child: Text("Fetching..."))),
            if (state.workflows != null) ...[
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: specificFilterWorkflowId,
                  onChanged: (v) {
                    setState(() {
                      specificFilterWorkflowId = v;
                    });
                  },
                  items: state.workflows!.map((e) {
                    return DropdownMenuItem<String>(
                      key: Key("${e.id}"),
                      value: e.id,
                      child: Text(e.name ?? e.description ?? ""),
                    );
                  }).toList(),
                ),
              ),
              ClearButton(clearFilterWorkflowID),
            ],
            if (state.workflows == null &&
                state.flowListStatus != FlowListStatus.loading)
              Center(child: Text("Error while fetching workflows")),
          ],
        );
      },
    );
  }

  FilterStatus(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Status",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [
        BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
          builder: (context, state) {
            if (state.status == EnumHandlingStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == EnumHandlingStatus.error) {
              return TryAgainButton(
                tryAgain: () =>
                    enumHandlingBloc.loadEnumsByType(EnumType.STATUS.name),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.enums[EnumType.STATUS.name] != null)
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.width * 0.22,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: state.enums[EnumType.STATUS.name]!
                              .map(
                                (e) => RadioListTile<String>(
                                  value: e,
                                  groupValue: specificFilterStatus,
                                  onChanged: (v) {
                                    setState(() {
                                      specificFilterStatus = v;
                                    });
                                  },
                                  selected: e == specificFilterStatus,
                                  title: Text(e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  contentPadding: EdgeInsets.zero,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ClearButton(clearFilterStatus),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  void onTimeChanged(
    BuildContext context,
    DateTime? value,
    _DateFields type,
  ) async {
    var res = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
    TimeOfDay? time;
    if (res != null) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: value?.hour ?? TimeOfDay.now().hour,
          minute: value?.minute ?? TimeOfDay.now().minute,
        ),
      );
    }
    if (res != null && time != null) {
      var result = DateTime(
        value?.year ?? DateTime.now().year,
        value?.month ?? DateTime.now().month,
        value?.day ?? DateTime.now().day,
        time.hour,
        time.minute,
      );
      setState(() {
        switch (type) {
          case _DateFields.deliveryDateBasedOnPickUp:
            specificFilterDeliveryDateBasedOnPickUp = result;
            break;
          case _DateFields.deliveryDateBasedOnUpload:
            specificFilterDeliveryDateBasedOnUpload = result;
            break;
          case _DateFields.requestedDeliveryTimeSlotEnd:
            specificFilterRequestedDeliveryTimeSlotEnd = result;
            break;
          case _DateFields.requestedDeliveryTimeSlotStart:
            specificFilterRequestedDeliveryTimeSlotStart = result;
        }
      });
    }
  }
}

class ClearButton extends StatelessWidget {
  const ClearButton(this.onClearTapped, {Key? key}) : super(key: key);

  final VoidCallback onClearTapped;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: TextButton(onPressed: onClearTapped, child: Text("Clear")),
      ),
    );
  }
}
