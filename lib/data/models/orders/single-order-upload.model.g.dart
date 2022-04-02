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
      orderPackage: (json['orderPackage'] as Map<String, dynamic>?)?.map(
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
      requestedDeliveryTimeSlotEnd: json['requestedDeliveryTimeSlotEnd'] == null
          ? null
          : DateTime.parse(json['requestedDeliveryTimeSlotEnd'] as String),
      requestedDeliveryTimeSlotStart: json['requestedDeliveryTimeSlotStart'] ==
              null
          ? null
          : DateTime.parse(json['requestedDeliveryTimeSlotStart'] as String),
      requestedDeliveryTimeSlotType: $enumDecodeNullable(
          _$DeliveryTimeSlotTypeEnumMap, json['requestedDeliveryTimeSlotType']),
      serviceLevel: $enumDecode(_$ServiceLevelEnumMap, json['serviceLevel']),
      serviceType: $enumDecode(_$ServiceTypeEnumMap, json['serviceType']),
      receiverDetail: ReceiverDetail.fromJson(
          json['receiverDetail'] as Map<String, dynamic>),
      senderDetail:
          SenderDetail.fromJson(json['senderDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SingleOrderUploadModelToJson(
        SingleOrderUploadModel instance) =>
    <String, dynamic>{
      'merchantId': instance.merchantId,
      'serviceType': _$ServiceTypeEnumMap[instance.serviceType],
      'serviceLevel': _$ServiceLevelEnumMap[instance.serviceLevel],
      'pickUpNotes': instance.pickUpNotes,
      'senderDetail': instance.senderDetail,
      'receiverDetail': instance.receiverDetail,
      'deliveryNotesFromMerchant': instance.deliveryNotesFromMerchant,
      'deliveryNotesFromReceiver': instance.deliveryNotesFromReceiver,
      'orderReference': instance.orderReference,
      'orderPackage': instance.orderPackage,
      'allowWeekendDelivery': instance.allowWeekendDelivery,
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
    };

const _$DeliveryTimeSlotTypeEnumMap = {
  DeliveryTimeSlotType.STANDARD: 'STANDARD',
  DeliveryTimeSlotType.TENANT_REQUESTED: 'TENANT_REQUESTED',
  DeliveryTimeSlotType.MERCHANT_REQUESTED: 'MERCHANT_REQUESTED',
  DeliveryTimeSlotType.RECEIVER_REQUESTED: 'RECEIVER_REQUESTED',
  DeliveryTimeSlotType.DRIVER_REQUESTED: 'DRIVER_REQUESTED',
  DeliveryTimeSlotType.CUSTOM: 'CUSTOM',
};

const _$ServiceLevelEnumMap = {
  ServiceLevel.INSTANT_60_MINUTES: 'INSTANT_60_MINUTES',
  ServiceLevel.WITHIN_4_HOURS: 'WITHIN_4_HOURS',
  ServiceLevel.SAME_DAY_BEFORE_10PM: 'SAME_DAY_BEFORE_10PM',
  ServiceLevel.NEXT_DAY: 'NEXT_DAY',
  ServiceLevel.STANDARD_1_TO_3_DAY: 'STANDARD_1_TO_3_DAY',
  ServiceLevel.STANDARD_INTERNATIONAL: 'STANDARD_INTERNATIONAL',
  ServiceLevel.EXPRESS_INTERNATIONAL: 'EXPRESS_INTERNATIONAL',
  ServiceLevel.PRE_ARRANGED: 'PRE_ARRANGED',
  ServiceLevel.LOCAL_PARCEL_LESSER_THAN_30KG: 'LOCAL_PARCEL_LESSER_THAN_30KG',
};

const _$ServiceTypeEnumMap = {
  ServiceType.LOCAL_PARCEL_LESSER_THAN_30KG: 'LOCAL_PARCEL_LESSER_THAN_30KG',
  ServiceType.LOCAL_BULKY_30KG_TO_100KG: 'LOCAL_BULKY_30KG_TO_100KG',
  ServiceType.LOCAL_EXTRA_LARGE_MORE_THAN_100KG:
      'LOCAL_EXTRA_LARGE_MORE_THAN_100KG',
  ServiceType.INTERNATIONAL_PARCEL_LESSER_THAN_30KG:
      'INTERNATIONAL_PARCEL_LESSER_THAN_30KG',
  ServiceType.INTERNATIONAL_BULKY_MORE_THAN_30KG:
      'INTERNATIONAL_BULKY_MORE_THAN_30KG',
  ServiceType.NEXT_DAY: 'NEXT_DAY',
};

UpdateSingleOrderModel _$UpdateSingleOrderModelFromJson(
        Map<String, dynamic> json) =>
    UpdateSingleOrderModel(
      orderId: json['orderId'] as String,
      barcodeAndTrackingNumber: json['barcodeAndTrackingNumber'] as String?,
      shippingLabelUrl: json['shippingLabelUrl'] as String?,
      trackingUrl: json['trackingUrl'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      serviceType:
          $enumDecodeNullable(_$ServiceTypeEnumMap, json['serviceType']),
      serviceLevel:
          $enumDecodeNullable(_$ServiceLevelEnumMap, json['serviceLevel']),
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
          : SenderDetail.fromJson(json['senderDetail'] as Map<String, dynamic>),
      receiverDetail: json['receiverDetail'] == null
          ? null
          : ReceiverDetail.fromJson(
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
      'status': _$StatusEnumMap[instance.status],
      'serviceType': _$ServiceTypeEnumMap[instance.serviceType],
      'serviceLevel': _$ServiceLevelEnumMap[instance.serviceLevel],
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

const _$StatusEnumMap = {
  Status.ORDER_CREATED: 'ORDER_CREATED',
  Status.AWB_PRINTED: 'AWB_PRINTED',
  Status.SHIPPING_LABEL_PRINTED: 'SHIPPING_LABEL_PRINTED',
  Status.READY_FOR_PICK_UP: 'READY_FOR_PICK_UP',
  Status.PICK_UP_CONFIRMED: 'PICK_UP_CONFIRMED',
  Status.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  Status.IN_WAREHOUSE_FOR_SORTING: 'IN_WAREHOUSE_FOR_SORTING',
  Status.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  Status.ON_VEHICLE_FOR_DELIVERY: 'ON_VEHICLE_FOR_DELIVERY',
  Status.ORDER_COMPLETED: 'ORDER_COMPLETED',
  Status.FAILED_PICK_UP: 'FAILED_PICK_UP',
  Status.DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  Status.DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER',
  Status.DELIVERY_ENDED_RETURNED_TO_SENDER: 'DELIVERY_ENDED_RETURNED_TO_SENDER',
  Status.CUSTOM: 'CUSTOM',
};
