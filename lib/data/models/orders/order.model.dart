import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/merchant.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/orders/order_package.model.dart';
import 'package:lng_adminapp/data/models/orders/order_reference.model.dart';
import 'package:lng_adminapp/data/models/receiver.model.dart';
import 'package:lng_adminapp/data/models/sender.model.dart';
import 'package:lng_adminapp/data/models/tenant.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';

import '../workflow/workflow.model.dart';

part 'order.model.g.dart';

@JsonSerializable()
class OrderList {
  final List<Order>? items;
  final Meta? meta;

  OrderList({this.items, this.meta});

  factory OrderList.fromJson(Map<String, dynamic> json) =>
      _$OrderListFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListToJson(this);

  @override
  String toString() => 'OrderList(items: $items, meta: $meta)';
}

@JsonSerializable()
class Order {
  Order({
    required this.id,
    this.allowWeekendDelivery,
    this.barcodeAndTrackingNumber,
    this.cashOnDeliveryAmount,
    this.cashOnDeliveryCurrency,
    this.cashOnDeliveryRequested,
    this.createdAt,
    this.deliveryDateBasedOnPickUp,
    this.deliveryDateBasedOnUpload,
    this.deliveryNotesFromMerchant,
    this.deliveryNotesFromReceiver,
    this.insuredAmount,
    this.insuredAmountCurrency,
    this.pickUpId,
    this.pickUpNotes,
    this.pickUpRequested,
    this.requestedDeliveryTimeSlotEnd,
    this.requestedDeliveryTimeSlotStart,
    this.requestedDeliveryTimeSlotType,
    required this.serviceLevel,
    required this.serviceType,
    this.shippingLabelUrl,
    required this.status,
    this.trackingUrl,
    this.updatedAt,
    this.createdBy,
    this.merchant,
    this.orderPackage,
    this.orderReference,
    this.receiverDetail,
    this.senderDetail,
    this.tenant,
    this.workflowEntity,
  });

  final String id;
  final String? barcodeAndTrackingNumber;
  final String? shippingLabelUrl;
  final String? trackingUrl;
  final Status status;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Tenant? tenant;
  final Merchant? merchant;
  final User? createdBy;
  final WorkflowEntity? workflowEntity;
  final SenderDetail? senderDetail;
  final ReceiverDetail? receiverDetail;
  final OrderReference? orderReference;
  final List<OrderPackage>? orderPackage;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  String toString() {
    return "Order: $id";
  }
}
