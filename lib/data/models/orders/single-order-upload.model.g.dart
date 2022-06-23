// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single-order-upload.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleOrderUploadModel _$SingleOrderUploadModelFromJson(
        Map<String, dynamic> json) =>
    SingleOrderUploadModel(
      merchantId: json['merchantId'] as String?,
      allowWeekendDelivery: json['allowWeekendDelivery'] as bool?,
      cashOnDeliveryAmount: json['cashOnDeliveryAmount'] as int?,
      cashOnDeliveryCurrency: json['cashOnDeliveryCurrency'] as String?,
      cashOnDeliveryRequested: json['cashOnDeliveryRequested'] as bool?,
      deliveryNotesFromMerchant: json['deliveryNotesFromMerchant'] as String?,
      deliveryNotesFromReceiver: json['deliveryNotesFromReceiver'] as String?,
      insuredAmount: json['insuredAmount'] as int?,
      insuredAmountCurrency: json['insuredAmountCurrency'] as String?,
      orderPackages: (json['orderPackages'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => OrderPackage.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
      orderReference: json['orderReference'] == null
          ? null
          : OrderReference.fromJson(
              json['orderReference'] as Map<String, dynamic>),
      pickUpNotes: json['pickUpNotes'] as String?,
      requestedDeliveryTimeSlotEnd:
          json['requestedDeliveryTimeSlotEnd'] as String?,
      requestedDeliveryTimeSlotStart:
          json['requestedDeliveryTimeSlotStart'] as String?,
      requestedDeliveryTimeSlotType: $enumDecodeNullable(
          _$DeliveryTimeSlotTypeEnumMap, json['requestedDeliveryTimeSlotType']),
      serviceLevel: json['serviceLevel'] as String,
      serviceType: json['serviceType'] as String,
      receiverDetail: ContactDetail.fromJson(
          json['receiverDetail'] as Map<String, dynamic>),
      senderDetail:
          ContactDetail.fromJson(json['senderDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleOrderUploadModelToJson(
        SingleOrderUploadModel instance) =>
    <String, dynamic>{
      'merchantId': instance.merchantId,
      'serviceType': instance.serviceType,
      'serviceLevel': instance.serviceLevel,
      'senderDetail': instance.senderDetail,
      'pickUpNotes': instance.pickUpNotes,
      'receiverDetail': instance.receiverDetail,
      'deliveryNotesFromMerchant': instance.deliveryNotesFromMerchant,
      'deliveryNotesFromReceiver': instance.deliveryNotesFromReceiver,
      'orderReference': instance.orderReference,
      'orderPackages': instance.orderPackages,
      'allowWeekendDelivery': instance.allowWeekendDelivery,
      'requestedDeliveryTimeSlotType':
          _$DeliveryTimeSlotTypeEnumMap[instance.requestedDeliveryTimeSlotType],
      'requestedDeliveryTimeSlotStart': instance.requestedDeliveryTimeSlotStart,
      'requestedDeliveryTimeSlotEnd': instance.requestedDeliveryTimeSlotEnd,
      'cashOnDeliveryRequested': instance.cashOnDeliveryRequested,
      'cashOnDeliveryAmount': instance.cashOnDeliveryAmount,
      'cashOnDeliveryCurrency': instance.cashOnDeliveryCurrency,
      'insuredAmount': instance.insuredAmount,
      'insuredAmountCurrency': instance.insuredAmountCurrency,
    };

const _$DeliveryTimeSlotTypeEnumMap = {
  DeliveryTimeSlotType.STANDARD: 'STANDARD',
  DeliveryTimeSlotType.TENANT_REQUESTED: 'TENANT_REQUESTED',
  DeliveryTimeSlotType.MERCHANT_REQUESTED: 'MERCHANT_REQUESTED',
  DeliveryTimeSlotType.RECEIVER_REQUESTED: 'RECEIVER_REQUESTED',
  DeliveryTimeSlotType.DRIVER_REQUESTED: 'DRIVER_REQUESTED',
  DeliveryTimeSlotType.CUSTOM: 'CUSTOM',
};

UpdateSingleOrderModel _$UpdateSingleOrderModelFromJson(
        Map<String, dynamic> json) =>
    UpdateSingleOrderModel(
      orderId: json['orderId'] as String,
      barcodeAndTrackingNumber: json['barcodeAndTrackingNumber'] as String?,
      shippingLabelUrl: json['shippingLabelUrl'] as String?,
      trackingUrl: json['trackingUrl'] as String?,
      status: json['status'] as String?,
      serviceType: json['serviceType'] as String?,
      serviceLevel: json['serviceLevel'] as String?,
      pickUpNotes: json['pickUpNotes'] as String?,
      deliveryNotesFromMerchant: json['deliveryNotesFromMerchant'] as String?,
      deliveryNotesFromReceiver: json['deliveryNotesFromReceiver'] as String?,
      deliveryDateBasedOnUpload: json['deliveryDateBasedOnUpload'] == null
          ? null
          : DateTime.parse(json['deliveryDateBasedOnUpload'] as String),
      deliveryDateBasedOnPickUp: json['deliveryDateBasedOnPickUp'] == null
          ? null
          : DateTime.parse(json['deliveryDateBasedOnPickUp'] as String),
      allowWeekendDelivery: json['allowWeekendDelivery'] as bool?,
      pickUpRequested: json['pickUpRequested'] as bool?,
      pickUpId: json['pickUpId'] as String?,
      requestedDeliveryTimeSlotType: $enumDecodeNullable(
          _$DeliveryTimeSlotTypeEnumMap, json['requestedDeliveryTimeSlotType']),
      requestedDeliveryTimeSlotStart: json['requestedDeliveryTimeSlotStart'] ==
              null
          ? null
          : DateTime.parse(json['requestedDeliveryTimeSlotStart'] as String),
      requestedDeliveryTimeSlotEnd: json['requestedDeliveryTimeSlotEnd'] == null
          ? null
          : DateTime.parse(json['requestedDeliveryTimeSlotEnd'] as String),
      cashOnDeliveryRequested: json['cashOnDeliveryRequested'] as bool?,
      cashOnDeliveryAmount: json['cashOnDeliveryAmount'] as int?,
      cashOnDeliveryCurrency: json['cashOnDeliveryCurrency'] as String?,
      insuredAmount: json['insuredAmount'] as int?,
      insuredAmountCurrency: json['insuredAmountCurrency'] as String?,
      workflowId: json['workflowId'] as String?,
      senderDetail: json['senderDetail'] == null
          ? null
          : ContactDetail.fromJson(
              json['senderDetail'] as Map<String, dynamic>),
      receiverDetail: json['receiverDetail'] == null
          ? null
          : ContactDetail.fromJson(
              json['receiverDetail'] as Map<String, dynamic>),
      orderReference: json['orderReference'] == null
          ? null
          : OrderReference.fromJson(
              json['orderReference'] as Map<String, dynamic>),
      orderPackage: (json['orderPackage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => OrderPackage.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$UpdateSingleOrderModelToJson(
        UpdateSingleOrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'barcodeAndTrackingNumber': instance.barcodeAndTrackingNumber,
      'shippingLabelUrl': instance.shippingLabelUrl,
      'trackingUrl': instance.trackingUrl,
      'status': instance.status,
      'serviceType': instance.serviceType,
      'serviceLevel': instance.serviceLevel,
      'pickUpNotes': instance.pickUpNotes,
      'deliveryNotesFromMerchant': instance.deliveryNotesFromMerchant,
      'deliveryNotesFromReceiver': instance.deliveryNotesFromReceiver,
      'deliveryDateBasedOnUpload':
          instance.deliveryDateBasedOnUpload?.toIso8601String(),
      'deliveryDateBasedOnPickUp':
          instance.deliveryDateBasedOnPickUp?.toIso8601String(),
      'allowWeekendDelivery': instance.allowWeekendDelivery,
      'pickUpRequested': instance.pickUpRequested,
      'pickUpId': instance.pickUpId,
      'requestedDeliveryTimeSlotType':
          _$DeliveryTimeSlotTypeEnumMap[instance.requestedDeliveryTimeSlotType],
      'requestedDeliveryTimeSlotStart':
          instance.requestedDeliveryTimeSlotStart?.toIso8601String(),
      'requestedDeliveryTimeSlotEnd':
          instance.requestedDeliveryTimeSlotEnd?.toIso8601String(),
      'cashOnDeliveryRequested': instance.cashOnDeliveryRequested,
      'cashOnDeliveryAmount': instance.cashOnDeliveryAmount,
      'cashOnDeliveryCurrency': instance.cashOnDeliveryCurrency,
      'insuredAmount': instance.insuredAmount,
      'insuredAmountCurrency': instance.insuredAmountCurrency,
      'workflowId': instance.workflowId,
      'senderDetail': instance.senderDetail,
      'receiverDetail': instance.receiverDetail,
      'orderReference': instance.orderReference,
      'orderPackage': instance.orderPackage,
    };
