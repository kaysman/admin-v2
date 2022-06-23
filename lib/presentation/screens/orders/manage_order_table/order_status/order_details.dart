import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/order_reference.model.dart';
import 'package:lng_adminapp/data/models/orders/order_timeline.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/contact-detail.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/blocs/enum_handling.bloc.dart';
import 'package:lng_adminapp/presentation/screens/operational_flow/flow_bloc.dart';
import 'package:lng_adminapp/presentation/screens/orders/manage_order_table/widgets/info.label.dart';
import 'package:lng_adminapp/presentation/screens/orders/order.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:timelines/timelines.dart';

class OrderDetails extends StatefulWidget {
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final generatedIDController = TextEditingController();
  final tenantNameController = TextEditingController();
  final orderCreatedByController = TextEditingController();
  final merchantNameController = TextEditingController();
  final barcodeController = TextEditingController();
  final shippingUrlController = TextEditingController();
  final trackingUrlController = TextEditingController();
  final merchantNoController = TextEditingController();
  final otherMerchantDetailsController = TextEditingController();
  final pickupIDController = TextEditingController();
  final codAmountController = TextEditingController();
  final codCurrencyController = TextEditingController();
  final insuredAmountController = TextEditingController();
  final insuredCurrencyController = TextEditingController();
  final createdController = TextEditingController();
  final updatedController = TextEditingController();

  String? orderStatus;
  String? serviceType;
  String? serviceLevel;
  WorkflowEntity? workflow;
  // TODO: Order Packages

  DateTime? uploadDate;
  DateTime? pickupDate;
  bool? weekendDelivery;
  bool? pickupRequested;
  DateTimeRange? timeslotRange;
  DateTime? timeslotStart;
  DateTime? timeslotEnd;
  bool? codRequested;
  DeliveryTimeSlotType? requestedDeliveryTimeSlotType;

  bool isEditMode = false;
  late OrderBloc orderBloc;
  late EnumHandlingBloc enumHandlingBloc;
  late WorkflowBloc workflowBloc;

  @override
  void initState() {
    // TODO
    generatedIDController.text = replaceStringWithDash(widget.order.id);
    tenantNameController.text =
        replaceStringWithDash(widget.order.tenant?.name);
    orderCreatedByController.text =
        replaceStringWithDash(widget.order.createdBy?.fullname);
    merchantNameController.text =
        replaceStringWithDash(widget.order.merchant?.contactName);
    barcodeController.text =
        replaceStringWithDash(widget.order.barcodeAndTrackingNumber);
    shippingUrlController.text =
        replaceStringWithDash(widget.order.shippingLabelUrl);
    trackingUrlController.text =
        replaceStringWithDash(widget.order.trackingUrl);
    workflow = widget.order.workflowEntity;
    orderStatus = widget.order.status;
    serviceType = widget.order.serviceType;
    serviceLevel = widget.order.serviceLevel;
    merchantNoController.text =
        replaceStringWithDash(widget.order.orderReference?.merchantOrderNumber);
    otherMerchantDetailsController.text =
        replaceStringWithDash(widget.order.orderReference?.others);
    uploadDate =
        DateTime.tryParse(widget.order.deliveryDateBasedOnUpload ?? '');
    pickupDate =
        DateTime.tryParse(widget.order.deliveryDateBasedOnPickUp ?? '');
    weekendDelivery = widget.order.allowWeekendDelivery;
    pickupRequested = widget.order.pickUpRequested;
    pickupIDController.text = replaceStringWithDash(widget.order.pickUpId);
    if (widget.order.requestedDeliveryTimeSlotStart != null &&
        widget.order.requestedDeliveryTimeSlotEnd != null)
      timeslotRange = DateTimeRange(
          start:
              DateTime.tryParse(widget.order.requestedDeliveryTimeSlotStart!) ??
                  DateTime.now(),
          end: DateTime.tryParse(widget.order.requestedDeliveryTimeSlotEnd!) ??
              DateTime.now());
    timeslotStart =
        DateTime.tryParse(widget.order.requestedDeliveryTimeSlotStart ?? '');
    timeslotEnd =
        DateTime.tryParse(widget.order.requestedDeliveryTimeSlotEnd ?? '');
    codRequested = widget.order.cashOnDeliveryRequested;
    codAmountController.text =
        replaceStringWithDash(widget.order.cashOnDeliveryAmount.toString());
    codCurrencyController.text =
        replaceStringWithDash(widget.order.cashOnDeliveryCurrency);
    insuredAmountController.text =
        replaceStringWithDash(widget.order.insuredAmount?.toString());
    insuredCurrencyController.text =
        replaceStringWithDash(widget.order.insuredAmountCurrency);
    createdController.text = widget.order.createdAt ?? '';
    updatedController.text = widget.order.updatedAt ?? '';

    orderBloc = context.read<OrderBloc>();
    enumHandlingBloc = context.read<EnumHandlingBloc>();
    workflowBloc = context.read<WorkflowBloc>();
    if (workflowBloc.state.workflows == null) {
      workflowBloc.loadWorkflows();
    }

    super.initState();
  }

  // @override
  // void dispose() {
  //   generatedIDController.dispose();
  //   tenantNameController.dispose();
  //   orderCreatedByController.dispose();
  //   merchantNameController.dispose();
  //   barcodeController.dispose();
  //   shippingUrlController.dispose();
  //   trackingUrlController.dispose();
  //   workflowNameController.dispose();
  //   merchantNoController.dispose();
  //   otherMerchantDetailsController.dispose();
  //   pickupIDController.dispose();
  //   codAmountController.dispose();
  //   codCurrencyController.dispose();
  //   codAmountController.dispose();
  //   insuredAmountController.dispose();
  //   insuredCurrencyController.dispose();
  //   super.dispose();
  // }

  get id => widget.order.id;
  get tenant => widget.order.tenant;
  get orderCreatedBy => widget.order.createdBy;
  get merchant => widget.order.merchant;
  get barcode => widget.order.barcodeAndTrackingNumber;
  get shippingUrl => widget.order.shippingLabelUrl;
  get trackingUrl => widget.order.trackingUrl;
  get status => widget.order.status;
  get getServiceType => widget.order.serviceType.toString();
  get getServiceLevel => widget.order.serviceLevel.toString();
  get merchantOrderNumber => widget.order.orderReference?.merchantOrderNumber;
  get orderReferenceOthers => widget.order.orderReference?.others;
  get deliveryDateBasedOnUpload =>
      DateTime.tryParse(widget.order.deliveryDateBasedOnUpload ?? '');
  get deliveryDateBasedOnPickUp =>
      DateTime.tryParse(widget.order.deliveryDateBasedOnPickUp ?? '');
  get allowWeekendDelivery => widget.order.allowWeekendDelivery;
  get pickUpRequested => widget.order.pickUpRequested;
  get timeslotstart =>
      DateTime.tryParse(widget.order.requestedDeliveryTimeSlotStart ?? '');
  get timeslotend =>
      DateTime.tryParse(widget.order.requestedDeliveryTimeSlotEnd ?? '');
  get reqTimeSlotType => widget.order.requestedDeliveryTimeSlotType;
  get cashOnDeliveryRequested => widget.order.cashOnDeliveryRequested;
  get cashOnDeliveryAmount => widget.order.cashOnDeliveryAmount;
  get cashOnDeliveryCurrency => widget.order.cashOnDeliveryCurrency;
  get insuredAmount => widget.order.insuredAmount;
  get insuredCurrency => widget.order.insuredAmountCurrency;
  get horizontalLine => Divider(color: kGrey3Color, thickness: 2.h);

  @override
  Widget build(BuildContext context) {
    print(workflow);
    return Container(
      child: SingleChildScrollView(
        child: BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
            builder: (context, enumState) {
          return BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  buildTimelines(widget.order.orderTimelines ?? []),
                  this.horizontalLine,
                  SizedBox(height: 32.h),
                  buildDetails(state, enumState),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  buildDetails(OrderState state, EnumHandlingState enumState) {
    var serviceTypes = enumState.enums[EnumType.SERVICE_TYPE.name] ?? [];
    var serviceLevels = enumState.enums[EnumType.SERVICE_LEVEL.name] ?? [];
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InfoWithLabel(
                        controller: generatedIDController,
                        label: "System generated ID",
                        editMode: false,
                        isEditable: false,
                      ),
                      SizedBox(height: 16.0.h),
                      InfoWithLabel(
                        controller: orderCreatedByController,
                        label: "Order created by",
                        editMode: false,
                        isEditable: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoWithLabel(
                        label: "Tenant name",
                        editMode: false,
                        controller: tenantNameController,
                      ),
                      SizedBox(height: 16.0.h),
                      InfoWithLabel(
                        label: "Merchant name",
                        editMode: false,
                        controller: merchantNameController,
                      ),
                    ],
                  ),
                ),
                if (!isEditMode)
                  InkWell(
                    onTap: () {
                      setState(() {
                        isEditMode = !isEditMode;
                      });
                    },
                    child: Row(
                      children: [
                        AppIcons.svgAsset(AppIcons.edit2),
                        SizedBox(width: 6),
                        Text("Edit"),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // General Details
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.w,
            ),
            title: Text(
              "General Details",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InfoWithLabel(
                      label: "Barcode/Tracking No",
                      editMode: isEditMode,
                      controller: barcodeController,
                    ),
                  ),
                  Expanded(
                    child: InfoWithLabel(
                      label: "Shipping label URL",
                      editMode: isEditMode,
                      controller: shippingUrlController,
                      infoType: InfoType.text,
                      // onValueChanged:,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              RowOfTwoChildren(
                child1: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoWithLabel(
                      label: "Tracking URL",
                      editMode: isEditMode,
                      controller: trackingUrlController,
                    ),
                    SizedBox(height: 32.0),
                    BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
                      builder: (context, state) {
                        return InfoWithLabel<String>(
                          label: "Service type",
                          editMode: isEditMode,
                          isLoading: state.status == EnumHandlingStatus.loading,
                          infoType: InfoType.dropdown,
                          value: serviceType,
                          onValueChanged: (v) {
                            setState(() {
                              serviceType = v;
                            });
                          },
                          items: serviceTypes
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
                child2: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<WorkflowBloc, WorkflowState>(
                      bloc: workflowBloc,
                      builder: (context, state) {
                        return InfoWithLabel<WorkflowEntity>(
                          label: "Workflow name",
                          editMode: isEditMode,
                          infoType: InfoType.dropdown,
                          value: workflow,
                          isLoading:
                              state.flowListStatus == FlowListStatus.loading,
                          items: (state.workflows ?? [])
                              .map((e) => DropdownMenuItem<WorkflowEntity>(
                                    child: Text(
                                      e.name ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    value: e,
                                  ))
                              .toList(),
                          onValueChanged: (v) {
                            setState(() {
                              workflow = v;
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 32.0),
                    BlocBuilder<EnumHandlingBloc, EnumHandlingState>(
                      builder: (context, state) {
                        return InfoWithLabel<String>(
                          label: "Service Level",
                          editMode: isEditMode,
                          isLoading: state.status == EnumHandlingStatus.loading,
                          infoType: InfoType.dropdown,
                          value: serviceLevel,
                          onValueChanged: (v) {
                            setState(() {
                              serviceLevel = v;
                            });
                          },
                          items: serviceLevels
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // General Details
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.w,
            ),
            title: Text(
              "Merchant Details",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              RowOfTwoChildren(
                child1: InfoWithLabel(
                  label: "Merchant order No",
                  editMode: isEditMode,
                  controller: merchantNoController,
                ),
                child2: InfoWithLabel(
                  label: "Other",
                  editMode: isEditMode,
                  controller: otherMerchantDetailsController,
                ),
              ),
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.w,
            ),
            title: Text(
              "Additional Details",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              Column(
                children: [
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Delivery date (upload)",
                      editMode: isEditMode,
                      infoType: InfoType.date,
                      dateValue: uploadDate,
                      onDateChanged: (v) {
                        print(v);
                        setState(() {
                          uploadDate = v;
                        });
                      },

                      // uploadDate
                    ),
                    child2: InfoWithLabel(
                      label: "Delivery date (pickup)",
                      editMode: isEditMode,
                      dateValue: pickupDate,
                      infoType: InfoType.date,
                      onDateChanged: (v) {
                        print(v);
                        setState(() {
                          pickupDate = v;
                        });
                      },
                      // date
                    ),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: allowWeekendDeliveryWidget(),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: pickUpTequestedWidget(),
                    child2: InfoWithLabel(
                      label: "Pickup ID",
                      editMode: isEditMode,
                      isEditable: false,
                      controller: pickupIDController,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: InfoWithLabel<DeliveryTimeSlotType>(
                      label: "Requested timeslot type",
                      editMode: isEditMode,
                      infoType: InfoType.dropdown,
                      value: requestedDeliveryTimeSlotType,
                      onValueChanged: (v) {
                        setState(() {
                          requestedDeliveryTimeSlotType = v;
                        });
                      },
                      items: DeliveryTimeSlotType.values
                          .map((e) => DropdownMenuItem<DeliveryTimeSlotType>(
                                value: e,
                                child: Text(
                                  e.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Timeslot start",
                      editMode: isEditMode,
                      infoType: InfoType.date,
                      dateValue: timeslotStart,
                      onDateChanged: (v) {
                        print(v);
                        setState(() {
                          timeslotStart = v;
                        });
                      },
                      // date
                    ),
                    child2: InfoWithLabel(
                      label: "Timeslot end",
                      editMode: isEditMode,
                      infoType: InfoType.date,
                      dateValue: timeslotEnd,
                      onDateChanged: (v) {
                        print(v);
                        setState(() {
                          timeslotEnd = v;
                        });
                      },
                      // date
                    ),
                  ),
                ],
              ),
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.symmetric(horizontal: 24.w),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 12.w,
            ),
            title: Text(
              "Cash On Delivery Details",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            children: [
              Column(
                children: [
                  RowOfTwoChildren(
                    child1: codRequestedWidget(),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "COD amount",
                      editMode: isEditMode,
                      controller: codAmountController,
                    ),
                    child2: InfoWithLabel(
                      label: "COD currency",
                      editMode: isEditMode,
                      controller: codCurrencyController,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Insured amount",
                      editMode: isEditMode,
                      controller: insuredAmountController,
                    ),
                    child2: InfoWithLabel(
                      label: "Insured currency",
                      editMode: isEditMode,
                      controller: insuredCurrencyController,
                    ),
                  ),
                  SizedBox(height: 32.0),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Created at",
                      editMode: false,
                      controller: createdController,
                      infoType: InfoType.text,

                      // date
                    ),
                    child2: InfoWithLabel(
                      label: "Updated at",
                      editMode: false,
                      infoType: InfoType.text,
                      controller: updatedController,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (AppService.hasPermission(PermissionType.UPDATE_ORDER) &&
              isEditMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: 'Cancel',
                  textColor: kBlack,
                  hasBorder: true,
                  borderColor: kGrey2Color,
                  primary: kWhite,
                  isLoading: false,
                  onPressed: () {
                    setState(() {
                      isEditMode = false;
                    });
                  },
                ),
                const SizedBox(width: 16.0),
                Button(
                  text: 'Done',
                  textColor: kWhite,
                  hasBorder: false,
                  primary: kPrimaryColor,
                  isLoading: state.updateSingleOrderStatus ==
                      UpdateSingleOrderStatus.loading,
                  onPressed: () async {
                    await submitOrderDetailsForm();
                  },
                ),
              ],
            ),
          if (AppService.hasPermission(PermissionType.UPDATE_ORDER))
            SizedBox(height: 32.h),
        ],
      ),
    );
  }

  allowWeekendDeliveryWidget() {
    return InfoWithLabel<bool>(
      label: "Weekend delivery",
      editMode: isEditMode,
      infoType: InfoType.dropdown,
      value: weekendDelivery,
      onValueChanged: (v) {
        setState(() {
          weekendDelivery = v;
        });
      },
      items: [true, false]
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                () {
                  switch (e) {
                    case true:
                      return 'Yes';
                    default:
                      return 'No';
                  }
                }(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: e,
            ),
          )
          .toList(),
    );
  }

  codRequestedWidget() {
    return InfoWithLabel<bool>(
      label: "COD request",
      editMode: isEditMode,
      infoType: InfoType.dropdown,
      value: codRequested,
      onValueChanged: (v) {
        setState(() {
          codRequested = v;
        });
      },
      items: [true, false]
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                () {
                  switch (e) {
                    case true:
                      return 'Yes';
                    default:
                      return 'No';
                  }
                }(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: e,
            ),
          )
          .toList(),
    );
  }

  pickUpTequestedWidget() {
    return InfoWithLabel<bool>(
      label: "Pickup requested",
      editMode: isEditMode,
      infoType: InfoType.dropdown,
      value: pickupRequested,
      onValueChanged: (v) {
        setState(() {
          pickupRequested = v;
        });
      },
      items: [true, false]
          .map(
            (e) => DropdownMenuItem(
              child: Text(
                () {
                  switch (e) {
                    case true:
                      return 'Yes';
                    default:
                      return 'No';
                  }
                }(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              value: e,
            ),
          )
          .toList(),
    );
  }

  buildTimelines(List<OrderTimeline> orderTimelines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Text(
            'Order history',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 24.h),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              minWidth: 0.3.sw,
              maxHeight: 0.25.sh,
            ),
            child: Timeline.tileBuilder(
              padding: EdgeInsets.only(left: 24.w, right: 24.w),
              theme: TimelineThemeData(
                nodePosition: 0,
                color: kGrey1Color,
                indicatorTheme: IndicatorThemeData(
                  position: 0,
                  size: 16.sp,
                  color: kGrey1Color,
                ),
                connectorTheme: ConnectorThemeData(
                  thickness: 1.w,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                connectionDirection: ConnectionDirection.before,
                itemCount: orderTimelines.length,
                indicatorBuilder: (_, index) {
                  return DotIndicator(
                    color: index == 0 ? Color(0xFFEE7911) : kGrey1Color,
                    size: 20.sp,
                  );
                },
                connectorBuilder: (_, index, ___) {
                  return SolidLineConnector(
                    indent: 0,
                    endIndent: 0,
                    direction: Axis.vertical,
                    color: index == 0 ? kGrey1Color : kGrey1Color,
                  );
                },
                contentsBuilder: (context, index) {
                  var timeline = orderTimelines[index];
                  return Container(
                    padding: EdgeInsets.only(
                      left: 18.w,
                      bottom: 24.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeline.createdAt ?? 'Null',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                timeline.description ?? 'Null',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Created by: ${timeline.createdBy?.fullname}',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: kGrey1Color),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  submitOrderDetailsForm() async {
    ContactDetail _receiverInfo = ContactDetail(
      firstName: widget.order.receiverDetail?.firstName,
      lastName: widget.order.receiverDetail?.lastName,
      phoneNumber: widget.order.receiverDetail?.phoneNumber,
      company: widget.order.receiverDetail?.company,
    );

    UpdateSingleOrderModel _data = UpdateSingleOrderModel(
      orderId: widget.order.id,
      barcodeAndTrackingNumber:
          checkIfChangedAndReturn(this.barcode, barcodeController.text),
      shippingLabelUrl:
          checkIfChangedAndReturn(this.shippingUrl, shippingUrlController.text),
      trackingUrl:
          checkIfChangedAndReturn(this.trackingUrl, trackingUrlController.text),
      status: checkIfChangedAndReturn(this.status, status),
      serviceType: checkIfChangedAndReturn(this.getServiceType, serviceType),
      serviceLevel: checkIfChangedAndReturn(this.getServiceLevel, serviceLevel),
      pickUpNotes: null,
      deliveryNotesFromMerchant: null,
      deliveryNotesFromReceiver: null,
      deliveryDateBasedOnUpload:
          checkIfChangedAndReturn(this.deliveryDateBasedOnUpload, uploadDate),
      deliveryDateBasedOnPickUp:
          checkIfChangedAndReturn(this.deliveryDateBasedOnPickUp, pickupDate),
      allowWeekendDelivery:
          checkIfChangedAndReturn(this.allowWeekendDelivery, weekendDelivery),
      pickUpRequested:
          checkIfChangedAndReturn(this.pickUpRequested, pickupRequested),
      pickUpId: null,
      // requestedDeliveryTimeSlotType: checkIfChangedAndReturn(), // TODO:
      requestedDeliveryTimeSlotStart:
          checkIfChangedAndReturn(this.timeslotstart, timeslotStart),
      requestedDeliveryTimeSlotEnd:
          checkIfChangedAndReturn(this.timeslotend, timeslotEnd),
      requestedDeliveryTimeSlotType: checkIfChangedAndReturn(
          this.reqTimeSlotType, requestedDeliveryTimeSlotType),
      cashOnDeliveryAmount: checkIfChangedAndReturn(
          this.cashOnDeliveryAmount, int.tryParse(codAmountController.text)),
      cashOnDeliveryCurrency: checkIfChangedAndReturn(
          this.cashOnDeliveryCurrency, codCurrencyController.text),
      cashOnDeliveryRequested:
          checkIfChangedAndReturn(this.cashOnDeliveryRequested, codRequested),
      insuredAmount: checkIfChangedAndReturn(
          this.insuredAmount, int.tryParse(insuredAmountController.text)),
      insuredAmountCurrency: checkIfChangedAndReturn(
          this.insuredCurrency, insuredAmountController.text),
      workflowId: workflow?.id,
      orderReference: OrderReference(
          merchantOrderNumber: checkIfChangedAndReturn(
              merchantOrderNumber, merchantNoController.text),
          others: checkIfChangedAndReturn(
              orderReferenceOthers, otherMerchantDetailsController.text)),
    );
    print(_data.toJson());
    // create model/ service and store this order
    await orderBloc.updateOrder(_data, context);
    setState(() => isEditMode = false);
  }
}
