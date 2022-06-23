// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderListToJson(OrderList instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      allowWeekendDelivery: json['allowWeekendDelivery'] as bool?,
      barcodeAndTrackingNumber: json['barcodeAndTrackingNumber'] as String?,
      cashOnDeliveryAmount: json['cashOnDeliveryAmount'] as int?,
      cashOnDeliveryCurrency: json['cashOnDeliveryCurrency'] as String?,
      cashOnDeliveryRequested: json['cashOnDeliveryRequested'] as bool?,
      createdAt: json['createdAt'] as String?,
      deliveryDateBasedOnPickUp: json['deliveryDateBasedOnPickUp'] as String?,
      deliveryDateBasedOnUpload: json['deliveryDateBasedOnUpload'] as String?,
      deliveryNotesFromMerchant: json['deliveryNotesFromMerchant'] as String?,
      deliveryNotesFromReceiver: json['deliveryNotesFromReceiver'] as String?,
      insuredAmount: json['insuredAmount'] as int?,
      insuredAmountCurrency: json['insuredAmountCurrency'] as String?,
      pickUpId: json['pickUpId'] as String?,
      pickUpNotes: json['pickUpNotes'] as String?,
      pickUpRequested: json['pickUpRequested'] as bool?,
      requestedDeliveryTimeSlotEnd:
          json['requestedDeliveryTimeSlotEnd'] as String?,
      requestedDeliveryTimeSlotStart:
          json['requestedDeliveryTimeSlotStart'] as String?,
      requestedDeliveryTimeSlotType: $enumDecodeNullable(
          _$DeliveryTimeSlotTypeEnumMap, json['requestedDeliveryTimeSlotType']),
      serviceLevel: json['serviceLevel'] as String?,
      serviceType: json['serviceType'] as String?,
      shippingLabelUrl: json['shippingLabelUrl'] as String?,
      status: json['status'] as String,
      trackingUrl: json['trackingUrl'] as String?,
      updatedAt: json['updatedAt'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      merchant: json['merchant'] == null
          ? null
          : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      orderPackage: (json['orderPackage'] as List<dynamic>?)
          ?.map((e) => OrderPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderReference: json['orderReference'] == null
          ? null
          : OrderReference.fromJson(
              json['orderReference'] as Map<String, dynamic>),
      receiverDetail: json['receiverDetail'] == null
          ? null
          : ContactDetail.fromJson(
              json['receiverDetail'] as Map<String, dynamic>),
      senderDetail: json['senderDetail'] == null
          ? null
          : ContactDetail.fromJson(
              json['senderDetail'] as Map<String, dynamic>),
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      workflowEntity: json['workflowEntity'] == null
          ? null
          : WorkflowEntity.fromJson(
              json['workflowEntity'] as Map<String, dynamic>),
      orderTimelines: (json['orderTimelines'] as List<dynamic>?)
          ?.map((e) => OrderTimeline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'barcodeAndTrackingNumber': instance.barcodeAndTrackingNumber,
      'shippingLabelUrl': instance.shippingLabelUrl,
      'trackingUrl': instance.trackingUrl,
      'status': instance.status,
      'serviceType': instance.serviceType,
      'serviceLevel': instance.serviceLevel,
      'pickUpNotes': instance.pickUpNotes,
      'deliveryNotesFromMerchant': instance.deliveryNotesFromMerchant,
      'deliveryNotesFromReceiver': instance.deliveryNotesFromReceiver,
      'deliveryDateBasedOnUpload': instance.deliveryDateBasedOnUpload,
      'deliveryDateBasedOnPickUp': instance.deliveryDateBasedOnPickUp,
      'allowWeekendDelivery': instance.allowWeekendDelivery,
      'pickUpRequested': instance.pickUpRequested,
      'pickUpId': instance.pickUpId,
      'requestedDeliveryTimeSlotType':
          _$DeliveryTimeSlotTypeEnumMap[instance.requestedDeliveryTimeSlotType],
      'requestedDeliveryTimeSlotStart': instance.requestedDeliveryTimeSlotStart,
      'requestedDeliveryTimeSlotEnd': instance.requestedDeliveryTimeSlotEnd,
      'cashOnDeliveryRequested': instance.cashOnDeliveryRequested,
      'cashOnDeliveryAmount': instance.cashOnDeliveryAmount,
      'cashOnDeliveryCurrency': instance.cashOnDeliveryCurrency,
      'insuredAmount': instance.insuredAmount,
      'insuredAmountCurrency': instance.insuredAmountCurrency,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tenant': instance.tenant,
      'merchant': instance.merchant,
      'createdBy': instance.createdBy,
      'workflowEntity': instance.workflowEntity,
      'senderDetail': instance.senderDetail,
      'receiverDetail': instance.receiverDetail,
      'orderReference': instance.orderReference,
      'orderPackage': instance.orderPackage,
      'orderTimelines': instance.orderTimelines,
    };

const _$DeliveryTimeSlotTypeEnumMap = {
  DeliveryTimeSlotType.STANDARD: 'STANDARD',
  DeliveryTimeSlotType.TENANT_REQUESTED: 'TENANT_REQUESTED',
  DeliveryTimeSlotType.MERCHANT_REQUESTED: 'MERCHANT_REQUESTED',
  DeliveryTimeSlotType.RECEIVER_REQUESTED: 'RECEIVER_REQUESTED',
  DeliveryTimeSlotType.DRIVER_REQUESTED: 'DRIVER_REQUESTED',
  DeliveryTimeSlotType.CUSTOM: 'CUSTOM',
};
