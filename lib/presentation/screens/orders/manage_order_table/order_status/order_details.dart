import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/contact-detail.model.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
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
  final workflowNameController = TextEditingController();
  final merchantNoController = TextEditingController();
  final otherMerchantDetailsController = TextEditingController();
  final pickupIDController = TextEditingController();
  final codAmountController = TextEditingController();
  final codCurrencyController = TextEditingController();
  final insuredAmountController = TextEditingController();
  final insuredCurrencyController = TextEditingController();

  late Status? orderStatus;
  late ServiceType? serviceType;
  late ServiceLevel? serviceLevel;
  // TODO: Order Packages

  DateTime? uploadDate;
  DateTime? pickupDate;
  bool? weekendDelivery;
  bool? pickupRequested;
  DateTimeRange? timeslotRange;
  DateTime? timeslotStart;
  DateTime? timeslotEnd;
  bool? codRequested;
  late String? createdAt;
  String? updatedAt;

  bool isEditMode = false;
  late OrderBloc orderBloc;

  @override
  void initState() {
    // TODO
    generatedIDController.text = replaceStringWithDash(widget.order.id);
    tenantNameController.text = replaceStringWithDash(widget.order.tenant?.name);
    orderCreatedByController.text = replaceStringWithDash(widget.order.createdBy?.fullname);
    merchantNameController.text = replaceStringWithDash(widget.order.merchant?.contactName);
    barcodeController.text = replaceStringWithDash(widget.order.barcodeAndTrackingNumber);
    shippingUrlController.text = replaceStringWithDash(widget.order.shippingLabelUrl);
    trackingUrlController.text = replaceStringWithDash(widget.order.trackingUrl);
    workflowNameController.text = replaceStringWithDash(widget.order.workflowEntity?.name);
    orderStatus = widget.order.status;
    serviceType = widget.order.serviceType;
    serviceLevel = widget.order.serviceLevel;
    merchantNoController.text =
        replaceStringWithDash(widget.order.orderReference?.merchantOrderNumber);
    otherMerchantDetailsController.text =
        replaceStringWithDash(widget.order.orderReference?.others);
    uploadDate = DateTime.tryParse(widget.order.deliveryDateBasedOnUpload ?? '');
    pickupDate = DateTime.tryParse(widget.order.deliveryDateBasedOnPickUp ?? '');
    weekendDelivery = widget.order.allowWeekendDelivery;
    pickupRequested = widget.order.pickUpRequested;
    pickupIDController.text = replaceStringWithDash(widget.order.pickUpId);
    if (widget.order.requestedDeliveryTimeSlotStart != null &&
        widget.order.requestedDeliveryTimeSlotEnd != null)
      timeslotRange = DateTimeRange(
          start: DateTime.tryParse(widget.order.requestedDeliveryTimeSlotStart!) ?? DateTime.now(),
          end: DateTime.tryParse(widget.order.requestedDeliveryTimeSlotEnd!) ?? DateTime.now());
    timeslotStart = DateTime.tryParse(widget.order.requestedDeliveryTimeSlotStart ?? '');
    timeslotEnd = DateTime.tryParse(widget.order.requestedDeliveryTimeSlotEnd ?? '');
    codRequested = widget.order.cashOnDeliveryRequested;
    codAmountController.text = replaceStringWithDash(widget.order.cashOnDeliveryAmount?.toString());
    codCurrencyController.text = replaceStringWithDash(widget.order.cashOnDeliveryCurrency);
    insuredAmountController.text = replaceStringWithDash(widget.order.insuredAmount?.toString());
    insuredCurrencyController.text = replaceStringWithDash(widget.order.insuredAmountCurrency);
    createdAt = widget.order.createdAt;
    updatedAt = widget.order.updatedAt;

    orderBloc = context.read<OrderBloc>();

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
  get workflow => widget.order.workflowEntity;
  get getServiceType => widget.order.serviceType;
  get getServiceLevel => widget.order.serviceLevel;
  get orderReference => widget.order.orderReference;
  get deliveryDateBasedOnUpload => widget.order.deliveryDateBasedOnUpload;
  get deliveryDateBasedOnPickUp => widget.order.deliveryDateBasedOnPickUp;
  get allowWeekendDelivery => widget.order.allowWeekendDelivery;
  get pickUpRequested => widget.order.pickUpRequested;
  get timeSlotStart => widget.order.requestedDeliveryTimeSlotStart;
  get timeSlotEnd => widget.order.requestedDeliveryTimeSlotEnd;
  get cashOnDeliveryRequested => widget.order.cashOnDeliveryRequested;
  get cashOnDeliveryAmount => widget.order.cashOnDeliveryAmount;
  get cashOnDeliveryCurrency => widget.order.cashOnDeliveryCurrency;
  get insuredAmount => widget.order.insuredAmount;
  get insuredCurrency => widget.order.insuredAmountCurrency;
  get horizontalLine => Divider(color: kGrey3Color, thickness: 2.h);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                buildTimelines(),
                this.horizontalLine,
                SizedBox(height: 32.h),
                buildDetails(state),
              ],
            );
          },
        ),
      ),
    );
  }

  buildDetails(OrderState state) {
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
                        editMode: isEditMode,
                        isEditable: false,
                      ),
                      SizedBox(height: 16.0.h),
                      InfoWithLabel(
                        controller: orderCreatedByController,
                        label: "Order created by",
                        editMode: isEditMode,
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
                        editMode: isEditMode,
                        controller: tenantNameController,
                      ),
                      SizedBox(height: 16.0.h),
                      InfoWithLabel(
                        label: "Merchant name",
                        editMode: isEditMode,
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
              RowOfTwoChildren(
                child1: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoWithLabel(
                      label: "Barcode/Tracking No",
                      editMode: isEditMode,
                      controller: barcodeController,
                    ),
                    SizedBox(height: 32.0.h),
                    InfoWithLabel(
                      label: "Tracking URL",
                      editMode: isEditMode,
                      controller: trackingUrlController,
                    ),
                    SizedBox(height: 32.0.h),
                    InfoWithLabel(
                      label: "Service type",
                      editMode: isEditMode,
                    ),
                  ],
                ),
                child2: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoWithLabel(
                      label: "Shipping label URL",
                      editMode: isEditMode,
                      controller: shippingUrlController,
                    ),
                    SizedBox(height: 32.0.h),
                    InfoWithLabel(
                      label: "Workflow name",
                      editMode: isEditMode,
                      controller: workflowNameController,
                    ),
                    SizedBox(height: 32.0.h),
                    InfoWithLabel(
                      label: "Service level",
                      editMode: isEditMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // General Details
          ExpansionTile(
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
          SizedBox(height: 16.h),
          ExpansionTile(
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
                      // uploadDate
                    ),
                    child2: InfoWithLabel(
                      label: "Delivery date (pickup)",
                      editMode: isEditMode,
                      // date
                    ),
                  ),
                  SizedBox(height: 32.0.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Weekend delivery",
                      editMode: isEditMode,
                      // yes
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Pickup requested",
                      editMode: isEditMode,
                      // yes
                    ),
                    child2: InfoWithLabel(
                      label: "Pickup ID",
                      editMode: isEditMode,
                      isEditable: false,
                      controller: pickupIDController,
                    ),
                  ),
                  SizedBox(height: 32.0.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Requested timeslot",
                      editMode: isEditMode,
                      // daterange
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Timeslot start",
                      editMode: isEditMode,
                      // date
                    ),
                    child2: InfoWithLabel(
                      label: "Timeslot end",
                      editMode: isEditMode,
                      // date
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ExpansionTile(
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
                    child1: InfoWithLabel(
                      label: "COD request",
                      editMode: isEditMode,
                      // yes
                    ),
                    child2: SizedBox.shrink(),
                  ),
                  SizedBox(height: 32.0.h),
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
                  SizedBox(height: 32.0.h),
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
                  SizedBox(height: 32.0.h),
                  RowOfTwoChildren(
                    child1: InfoWithLabel(
                      label: "Created at",
                      editMode: isEditMode,
                      // date
                    ),
                    child2: InfoWithLabel(
                      label: "Updated at",
                      editMode: isEditMode,
                      // date
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (AppService.hasPermission(PermissionType.UPDATE_ORDER))
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
                  isLoading: state.updateSingleOrderStatus == UpdateSingleOrderStatus.loading,
                  onPressed: () async {
                    await submitOrderDetailsForm();
                  },
                ),
              ],
            ),
          if (AppService.hasPermission(PermissionType.UPDATE_ORDER)) SizedBox(height: 32.h),
        ],
      ),
    );
  }

  buildTimelines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w),
          child: Text(
            'Order history',
            style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 24.h),
        SizedBox(
          height: 0.3.sh,
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
              contentsBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: 18.w,
                    bottom: 24.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oct 04',
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        width: 24.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Picked up by Mike',
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '12:30',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: kGrey1Color,
                                ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: 4,
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
            ),
          ),
        ),
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
      barcodeAndTrackingNumber: checkIfChangedAndReturn(this.barcode, barcodeController.text),
      shippingLabelUrl: checkIfChangedAndReturn(this.shippingUrl, shippingUrlController.text),
      trackingUrl: checkIfChangedAndReturn(this.trackingUrl, trackingUrlController.text),
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
      allowWeekendDelivery: checkIfChangedAndReturn(this.allowWeekendDelivery, weekendDelivery),
      pickUpRequested: checkIfChangedAndReturn(this.pickUpRequested, pickupRequested),
      pickUpId: null,
      requestedDeliveryTimeSlotType: null,
      requestedDeliveryTimeSlotStart: null,
      cashOnDeliveryAmount:
          checkIfChangedAndReturn(this.cashOnDeliveryAmount, codAmountController.text),
      cashOnDeliveryCurrency:
          checkIfChangedAndReturn(this.cashOnDeliveryCurrency, codCurrencyController.text),
      cashOnDeliveryRequested: checkIfChangedAndReturn(this.cashOnDeliveryRequested, codRequested),
      insuredAmount: checkIfChangedAndReturn(this.insuredAmount, insuredAmountController.text),
      insuredAmountCurrency:
          checkIfChangedAndReturn(this.insuredCurrency, insuredAmountController.text),
      workflowId: null,
    );

    // create model/ service and store this order
    orderBloc.updateOrder(_data, context);
    setState(() => isEditMode = false);
  }
}
