// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderList _$OrderListFromJson(Map<String, dynamic> json) => OrderList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
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
      serviceLevel:
          $enumDecodeNullable(_$ServiceLevelEnumMap, json['serviceLevel']),
      serviceType:
          $enumDecodeNullable(_$ServiceTypeEnumMap, json['serviceType']),
      shippingLabelUrl: json['shippingLabelUrl'] as String?,
      status: $enumDecode(_$StatusEnumMap, json['status']),
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
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'barcodeAndTrackingNumber': instance.barcodeAndTrackingNumber,
      'shippingLabelUrl': instance.shippingLabelUrl,
      'trackingUrl': instance.trackingUrl,
      'status': _$StatusEnumMap[instance.status],
      'serviceType': _$ServiceTypeEnumMap[instance.serviceType],
      'serviceLevel': _$ServiceLevelEnumMap[instance.serviceLevel],
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
