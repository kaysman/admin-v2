import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/data/data.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/filter_parameters.dart';
import 'package:lng_adminapp/data/services/order.service.dart';
import 'package:lng_adminapp/presentation/screens/merchants/merchants.bloc.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow_list/flow_bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:lng_adminapp/shared.dart';

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
  late OrderBloc orderBloc;

  DateTime? startDate;
  clearStartDate() {
    setState(() {
      startDate = null;
    });
  }

  DateTime? endDate;
  clearEndDate() {
    setState(() {
      endDate = null;
    });
  }

  Status? specificFilterStatus;
  clearFilterStatus() {
    setState(() {
      specificFilterStatus = null;
    });
  }

  String? specificFilterTenantId;
  clearFilterTenantID() {
    setState(() {
      specificFilterTenantId = null;
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

  ServiceType? specificFilterServiceType;
  clearFilterServiceType() {
    setState(() {
      specificFilterServiceType = null;
    });
  }

  ServiceLevel? specificFilterServiceLevel;
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

  DeliveryTimeSlotType? specificFilterRequestedDeliveryTimeSlotType;
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
      codAmountController.text = "";
    });
  }

  String? specificFilterCashOnDeliveryCurrency;
  clearFilterCashOnDeliveryCurrency() {
    setState(() {
      specificFilterCashOnDeliveryCurrency = null;
    });
  }

  final insuredAmountController = TextEditingController();
  clearFilterInsuredAmount() {
    setState(() {
      insuredAmountController.text = "";
    });
  }

  String? specificFilterInsuredAmountCurrency;
  clearFilterInsuredAmountCurrency() {
    setState(() {
      specificFilterInsuredAmountCurrency = null;
    });
  }

  clearAllFilters() {
    setState(() {
      startDate = null;
      endDate = null;
      specificFilterStatus = null;
      specificFilterTenantId = null;
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
      specificFilterCashOnDeliveryRequested = null;
      codAmountController.text = "";
      specificFilterCashOnDeliveryCurrency = null;
      insuredAmountController.text = "";
      specificFilterInsuredAmountCurrency = null;
    });
  }

  @override
  void initState() {
    workflowBloc = BlocProvider.of<WorkflowBloc>(context);
    merchantBloc = BlocProvider.of<MerchantBloc>(context);
    orderBloc = BlocProvider.of<OrderBloc>(context);
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
                            onTap: () => Navigator.of(context).pop(),
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
                                await orderBloc.loadOrders(
                                  OrderFilterParameters(
                                    page: OrderService.currentPage.value,
                                    limit: "10",
                                    startDate: startDate != null
                                        ? DateHelper.yyyyMMdd(startDate!)
                                        : null,
                                    endDate: endDate != null
                                        ? DateHelper.yyyyMMdd(endDate!)
                                        : null,
                                    specificFilterStatus:
                                        specificFilterStatus?.name,
                                    specificFilterTenantId:
                                        specificFilterTenantId,
                                    specificFilterMerchantId:
                                        specificFilterMerchantId,
                                    specificFilterCreatedById:
                                        specificFilterCreatedById,
                                    specificFilterWorkflowId:
                                        specificFilterWorkflowId,
                                    specificFilterServiceType:
                                        specificFilterServiceType?.name,
                                    specificFilterServiceLevel:
                                        specificFilterServiceLevel?.name,
                                    specificFilterDeliveryDateBasedOnUpload:
                                        specificFilterDeliveryDateBasedOnUpload !=
                                                null
                                            ? DateHelper.yyyyMMdd(
                                                specificFilterDeliveryDateBasedOnUpload!)
                                            : null,
                                    specificFilterDeliveryDateBasedOnPickUp:
                                        specificFilterDeliveryDateBasedOnPickUp !=
                                                null
                                            ? DateHelper.yyyyMMdd(
                                                specificFilterDeliveryDateBasedOnPickUp!)
                                            : null,
                                    specificFilterAllowWeekendDelivery: () {
                                      switch (
                                          specificFilterAllowWeekendDelivery) {
                                        case true:
                                          return "true";
                                        case false:
                                          return "false";
                                        default:
                                          return null;
                                      }
                                    }(),
                                    specificFilterPickUpRequested: () {
                                      switch (specificFilterPickUpRequested) {
                                        case true:
                                          return "true";
                                        case false:
                                          return "false";
                                        default:
                                          return null;
                                      }
                                    }(),
                                    specificFilterRequestedDeliveryTimeSlotType:
                                        specificFilterRequestedDeliveryTimeSlotType
                                            ?.name,
                                    specificFilterRequestedDeliveryTimeSlotStart:
                                        specificFilterRequestedDeliveryTimeSlotStart !=
                                                null
                                            ? DateHelper.yyyyMMdd(
                                                specificFilterRequestedDeliveryTimeSlotStart!)
                                            : null,
                                    specificFilterRequestedDeliveryTimeSlotEnd:
                                        specificFilterRequestedDeliveryTimeSlotEnd !=
                                                null
                                            ? DateHelper.yyyyMMdd(
                                                specificFilterRequestedDeliveryTimeSlotEnd!)
                                            : null,
                                    specificFilterCashOnDeliveryRequested: () {
                                      switch (
                                          specificFilterCashOnDeliveryRequested) {
                                        case true:
                                          return "true";
                                        case false:
                                          return "false";
                                        default:
                                          return null;
                                      }
                                    }(),
                                    specificFilterCashOnDeliveryAmount:
                                        codAmountController.text,
                                    specificFilterCashOnDeliveryCurrency:
                                        specificFilterCashOnDeliveryCurrency,
                                    specificFilterInsuredAmount:
                                        insuredAmountController.text,
                                    specificFilterInsuredAmountCurrency:
                                        specificFilterInsuredAmountCurrency,
                                  ),
                                );
                                Navigator.of(context).pop();
                              } catch (_) {
                                print(_.toString());
                              }
                            },
                          );
                        }),
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isDense: true,
            isExpanded: true,
            value: specificFilterInsuredAmountCurrency,
            onChanged: (v) {
              setState(() {
                specificFilterInsuredAmountCurrency = v;
              });
            },
            items: availableCurrencies.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
        ),
        _ClearButton(clearFilterInsuredAmountCurrency),
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
        TextFormField(controller: insuredAmountController),
        _ClearButton(clearFilterInsuredAmount),
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            isDense: true,
            isExpanded: true,
            value: specificFilterCashOnDeliveryCurrency,
            onChanged: (v) {
              setState(() {
                specificFilterCashOnDeliveryCurrency = v;
              });
            },
            items: availableCurrencies.map((e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
        ),
        _ClearButton(clearFilterCashOnDeliveryCurrency),
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
        TextFormField(controller: codAmountController),
        _ClearButton(clearFilterCashOnDeliveryAmount),
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
          value: specificFilterAllowWeekendDelivery ?? false,
          onChanged: (v) {
            setState(() {
              specificFilterAllowWeekendDelivery = v;
            });
          },
          title: Text(
            "Cash on Delivery Requested?",
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: Text(
            "Some description about this filter",
            style: Theme.of(context).textTheme.caption,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        _ClearButton(clearFilterCashOnDeliveryRequested),
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
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate:
                  specificFilterRequestedDeliveryTimeSlotEnd ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                specificFilterRequestedDeliveryTimeSlotEnd = res;
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
                if (specificFilterRequestedDeliveryTimeSlotEnd != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterRequestedDeliveryTimeSlotEnd!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        _ClearButton(clearFilterRequestedDeliveryTimeSlotEnd),
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
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate: specificFilterRequestedDeliveryTimeSlotStart ??
                  DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                specificFilterRequestedDeliveryTimeSlotStart = res;
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
                if (specificFilterRequestedDeliveryTimeSlotStart != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterRequestedDeliveryTimeSlotStart!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        _ClearButton(clearFilterRequestedDeliveryTimeSlotStart),
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<DeliveryTimeSlotType>(
            isDense: true,
            isExpanded: true,
            value: specificFilterRequestedDeliveryTimeSlotType,
            onChanged: (v) {
              setState(() {
                specificFilterRequestedDeliveryTimeSlotType = v;
              });
            },
            items: DeliveryTimeSlotType.values.map((e) {
              return DropdownMenuItem<DeliveryTimeSlotType>(
                value: e,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
        ),
        _ClearButton(clearFilterRequestedDeliveryTimeSlotType),
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
          value: specificFilterAllowWeekendDelivery ?? false,
          onChanged: (v) {
            setState(() {
              specificFilterAllowWeekendDelivery = v;
            });
          },
          title: Text(
            "Allowing weekend delivery?",
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: Text(
            "Some description about this filter",
            style: Theme.of(context).textTheme.caption,
          ),
          contentPadding: EdgeInsets.zero,
        ),
        _ClearButton(clearFilterAllowWeekendDelivery),
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
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate:
                  specificFilterDeliveryDateBasedOnPickUp ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                specificFilterDeliveryDateBasedOnPickUp = res;
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
                if (specificFilterDeliveryDateBasedOnPickUp != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterDeliveryDateBasedOnPickUp!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        _ClearButton(clearFilterDeliveryDateBasedOnPickUp),
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
          onTap: () async {
            var res = await showDatePicker(
              context: context,
              initialDate:
                  specificFilterDeliveryDateBasedOnUpload ?? DateTime.now(),
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
            );
            if (res != null) {
              setState(() {
                specificFilterDeliveryDateBasedOnUpload = res;
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
                if (specificFilterDeliveryDateBasedOnUpload != null)
                  Expanded(
                      child: Text(DateHelper.yyyyMMdd(
                          specificFilterDeliveryDateBasedOnUpload!))),
                AppIcons.svgAsset(AppIcons.calendar),
              ],
            ),
          ),
        ),
        _ClearButton(clearFilterDeliveryDateBasedOnUpload),
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<ServiceLevel>(
            isDense: true,
            isExpanded: true,
            value: specificFilterServiceLevel,
            onChanged: (v) {
              setState(() {
                specificFilterServiceLevel = v;
              });
            },
            items: ServiceLevel.values.map((e) {
              return DropdownMenuItem<ServiceLevel>(
                value: e,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
        ),
        _ClearButton(clearFilterServiceLevel),
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
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<ServiceType>(
            isDense: true,
            isExpanded: true,
            value: specificFilterServiceType,
            onChanged: (v) {
              setState(() {
                specificFilterServiceType = v;
              });
            },
            items: ServiceType.values.map((e) {
              return DropdownMenuItem<ServiceType>(
                value: e,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
        ),
        _ClearButton(clearFilterServiceType),
      ],
    );
  }

  FilterCreatedBy(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Created by",
        style: Theme.of(context).textTheme.headline3,
      ),
      children: [],
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
              _ClearButton(clearFilterMerchantID)
            ],
            if (state.listMerchantStatus != ListMerchantStatus.loading &&
                state.merchants == null)
              Center(child: Text("Error while fetching merchants")),
          ],
        );
      },
    );
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
        _ClearButton(clearEndDate),
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
        _ClearButton(clearStartDate),
      ],
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
              _ClearButton(clearFilterWorkflowID),
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
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.3,
        //   child: SingleChildScrollView(
        //     child:
        //   ),
        // ),
        ...[Status.ORDER_CREATED].map((e) => RadioListTile<Status>(
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
            )),
        _ClearButton(clearFilterStatus),
      ],
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton(this.onClearTapped, {Key? key}) : super(key: key);

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
