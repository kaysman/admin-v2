import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/order_package.model.dart';
import 'package:lng_adminapp/data/models/orders/order_reference.model.dart';
import 'package:lng_adminapp/data/models/receiver.model.dart';

import '../sender.model.dart';

part 'single-order-upload.model.g.dart';

@JsonSerializable()
class SingleOrderUploadModel {
  SingleOrderUploadModel({
    this.merchantId,
    this.allowWeekendDelivery,
    this.cashOnDeliveryAmount,
    this.cashOnDeliveryCurrency,
    this.cashOnDeliveryRequested,
    this.deliveryNotesFromMerchant,
    this.deliveryNotesFromReceiver,
    this.insuredAmount,
    this.insuredAmountCurrency,
    this.orderPackage,
    this.orderReference,
    this.pickUpNotes,
    this.requestedDeliveryTimeSlotEnd,
    this.requestedDeliveryTimeSlotStart,
    this.requestedDeliveryTimeSlotType,
    required this.serviceLevel,
    required this.serviceType,
    required this.receiverDetail,
    required this.senderDetail,
  });

  final String? merchantId;
  final ServiceType serviceType;
  final ServiceLevel serviceLevel;
  final String? pickUpNotes;
  final SenderDetail senderDetail;
  final ReceiverDetail receiverDetail;
  final String? deliveryNotesFromMerchant;
  final String? deliveryNotesFromReceiver;
  final OrderReference? orderReference;
  final Map<String, List<OrderPackage>>? orderPackage;
  final bool? allowWeekendDelivery;
  final DeliveryTimeSlotType? requestedDeliveryTimeSlotType;
  final DateTime? requestedDeliveryTimeSlotStart;
  final DateTime? requestedDeliveryTimeSlotEnd;
  final bool? cashOnDeliveryRequested;
  final int? cashOnDeliveryAmount;
  final String? cashOnDeliveryCurrency;
  final int? insuredAmount;
  final String? insuredAmountCurrency;

  factory SingleOrderUploadModel.fromJson(Map<String, dynamic> json) =>
      _$SingleOrderUploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$SingleOrderUploadModelToJson(this);
}

@JsonSerializable()
class UpdateSingleOrderModel {
  UpdateSingleOrderModel({
    required this.orderId,
    this.barcodeAndTrackingNumber,
    this.shippingLabelUrl,
    this.trackingUrl,
    this.status,
    this.serviceType,
    this.serviceLevel,
    this.pickUpNotes,
    this.deliveryNotesFromMerchant,
    this.deliveryNotesFromReceiver,
    this.deliveryDateBasedOnUpload,
    this.deliveryDateBasedOnPickUp,
    this.allowWeekendDelivery,
    this.pickUpRequested,
    this.pickUpId,
    this.requestedDeliveryTimeSlotType,
    this.requestedDeliveryTimeSlotStart,
    this.requestedDeliveryTimeSlotEnd,
    this.cashOnDeliveryRequested,
    this.cashOnDeliveryAmount,
    this.cashOnDeliveryCurrency,
    this.insuredAmount,
    this.insuredAmountCurrency,
    this.workflowId,
    this.senderDetail,
    this.receiverDetail,
    this.orderReference,
    this.orderPackage,
  });

  final String orderId;
  final String? barcodeAndTrackingNumber;
  final String? shippingLabelUrl;
  final String? trackingUrl;
  final Status? status;
  final ServiceType? serviceType;
  final ServiceLevel? serviceLevel;
  final String? pickUpNotes;
  final String? deliveryNotesFromMerchant;
  final String? deliveryNotesFromReceiver;
  final DateTime? deliveryDateBasedOnUpload;
  final DateTime? deliveryDateBasedOnPickUp;
  final bool? allowWeekendDelivery;
  final bool? pickUpRequested;
  final String? pickUpId;
  final DeliveryTimeSlotType? requestedDeliveryTimeSlotType;
  final DateTime? requestedDeliveryTimeSlotStart;
  final DateTime? requestedDeliveryTimeSlotEnd;
  final bool? cashOnDeliveryRequested;
  final int? cashOnDeliveryAmount;
  final String? cashOnDeliveryCurrency;
  final int? insuredAmount;
  final String? insuredAmountCurrency;
  final String? workflowId;
  final SenderDetail? senderDetail;
  final ReceiverDetail? receiverDetail;
  final OrderReference? orderReference;
  // multi order package
  final Map<String, List<OrderPackage>>? orderPackage;

  factory UpdateSingleOrderModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateSingleOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateSingleOrderModelToJson(this);
}
