// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapping-response.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MappingResponse _$MappingResponseFromJson(Map<String, dynamic> json) =>
    MappingResponse(
      id: json['id'] as String?,
      count: json['count'] as int?,
      headers:
          (json['headers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mapping: json['mapping'] == null
          ? null
          : Mapping.fromJson(json['mapping'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MappingResponseToJson(MappingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'headers': instance.headers,
      'mapping': instance.mapping,
    };

Mapping _$MappingFromJson(Map<String, dynamic> json) => Mapping(
      orderInformation: json['orderInformation'] == null
          ? null
          : OrderDetails.fromJson(
              json['orderInformation'] as Map<String, dynamic>),
      receiverInformation: json['receiverInformation'] == null
          ? null
          : DataMap.fromJson(
              json['receiverInformation'] as Map<String, dynamic>),
      senderInformation: json['senderInformation'] == null
          ? null
          : DataMap.fromJson(json['senderInformation'] as Map<String, dynamic>),
      notes: json['notes'] == null
          ? null
          : NoteMap.fromJson(json['notes'] as Map<String, dynamic>),
      otherInformation: json['otherInformation'] == null
          ? null
          : OtherInformationMap.fromJson(
              json['otherInformation'] as Map<String, dynamic>),
      serviceInformation: json['serviceInformation'] == null
          ? null
          : ServiceInformationMap.fromJson(
              json['serviceInformation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MappingToJson(Mapping instance) => <String, dynamic>{
      'serviceInformation': instance.serviceInformation,
      'senderInformation': instance.senderInformation,
      'receiverInformation': instance.receiverInformation,
      'notes': instance.notes,
      'orderInformation': instance.orderInformation,
      'otherInformation': instance.otherInformation,
    };

DataMap _$DataMapFromJson(Map<String, dynamic> json) => DataMap(
      firstName: json['firstName'] == null
          ? null
          : KeyBoolPair.fromJson(json['firstName'] as Map<String, dynamic>),
      lastName: json['lastName'] == null
          ? null
          : KeyBoolPair.fromJson(json['lastName'] as Map<String, dynamic>),
      emailAddress: json['emailAddress'] == null
          ? null
          : KeyBoolPair.fromJson(json['emailAddress'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] == null
          ? null
          : KeyBoolPair.fromJson(json['phoneNumber'] as Map<String, dynamic>),
      company: json['company'] == null
          ? null
          : KeyBoolPair.fromJson(json['company'] as Map<String, dynamic>),
      addressLineOne: json['addressLineOne'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['addressLineOne'] as Map<String, dynamic>),
      addressLineThree: json['addressLineThree'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['addressLineThree'] as Map<String, dynamic>),
      addressLineTwo: json['addressLineTwo'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['addressLineTwo'] as Map<String, dynamic>),
      addressType: json['addressType'] == null
          ? null
          : KeyBoolPair.fromJson(json['addressType'] as Map<String, dynamic>),
      city: json['city'] == null
          ? null
          : KeyBoolPair.fromJson(json['city'] as Map<String, dynamic>),
      country: json['country'] == null
          ? null
          : KeyBoolPair.fromJson(json['country'] as Map<String, dynamic>),
      latitude: json['latitude'] == null
          ? null
          : KeyBoolPair.fromJson(json['latitude'] as Map<String, dynamic>),
      longitude: json['longitude'] == null
          ? null
          : KeyBoolPair.fromJson(json['longitude'] as Map<String, dynamic>),
      postalCode: json['postalCode'] == null
          ? null
          : KeyBoolPair.fromJson(json['postalCode'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataMapToJson(DataMap instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'company': instance.company,
      'addressLineOne': instance.addressLineOne,
      'addressLineTwo': instance.addressLineTwo,
      'addressLineThree': instance.addressLineThree,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'country': instance.country,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'addressType': instance.addressType,
    };

KeyBoolPair _$KeyBoolPairFromJson(Map<String, dynamic> json) => KeyBoolPair(
      isRequired: json['isRequired'] as bool?,
      key: json['key'],
    );

Map<String, dynamic> _$KeyBoolPairToJson(KeyBoolPair instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'key': instance.key,
    };

OrderDetails _$OrderDetailsFromJson(Map<String, dynamic> json) => OrderDetails(
      orderNumber: json['orderNumber'] == null
          ? null
          : KeyBoolPair.fromJson(json['orderNumber'] as Map<String, dynamic>),
      description: json['description'] == null
          ? null
          : KeyBoolPair.fromJson(json['description'] as Map<String, dynamic>),
      quantity: json['quantity'] == null
          ? null
          : KeyBoolPair.fromJson(json['quantity'] as Map<String, dynamic>),
      weight: json['weight'] == null
          ? null
          : KeyBoolPair.fromJson(json['weight'] as Map<String, dynamic>),
      currency: json['currency'] == null
          ? null
          : KeyBoolPair.fromJson(json['currency'] as Map<String, dynamic>),
      dimensionUnit: json['dimensionUnit'] == null
          ? null
          : KeyBoolPair.fromJson(json['dimensionUnit'] as Map<String, dynamic>),
      height: json['height'] == null
          ? null
          : KeyBoolPair.fromJson(json['height'] as Map<String, dynamic>),
      length: json['length'] == null
          ? null
          : KeyBoolPair.fromJson(json['length'] as Map<String, dynamic>),
      name: json['name'] == null
          ? null
          : KeyBoolPair.fromJson(json['name'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : KeyBoolPair.fromJson(json['price'] as Map<String, dynamic>),
      type: json['type'] == null
          ? null
          : KeyBoolPair.fromJson(json['type'] as Map<String, dynamic>),
      weightUnit: json['weightUnit'] == null
          ? null
          : KeyBoolPair.fromJson(json['weightUnit'] as Map<String, dynamic>),
      width: json['width'] == null
          ? null
          : KeyBoolPair.fromJson(json['width'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDetailsToJson(OrderDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'orderNumber': instance.orderNumber,
      'description': instance.description,
      'currency': instance.currency,
      'dimensionUnit': instance.dimensionUnit,
      'height': instance.height,
      'length': instance.length,
      'price': instance.price,
      'quantity': instance.quantity,
      'type': instance.type,
      'width': instance.width,
      'weight': instance.weight,
      'weightUnit': instance.weightUnit,
    };

NoteMap _$NoteMapFromJson(Map<String, dynamic> json) => NoteMap(
      deliveryNoteMerchant: json['deliveryNoteMerchant'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['deliveryNoteMerchant'] as Map<String, dynamic>),
      deliveryNoteReceiver: json['deliveryNoteReceiver'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['deliveryNoteReceiver'] as Map<String, dynamic>),
      otherNotes: json['otherNotes'] == null
          ? null
          : KeyBoolPair.fromJson(json['otherNotes'] as Map<String, dynamic>),
      pickupNote: json['pickupNote'] == null
          ? null
          : KeyBoolPair.fromJson(json['pickupNote'] as Map<String, dynamic>),
      productNote: json['productNote'] == null
          ? null
          : KeyBoolPair.fromJson(json['productNote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NoteMapToJson(NoteMap instance) => <String, dynamic>{
      'pickupNote': instance.pickupNote,
      'deliveryNoteMerchant': instance.deliveryNoteMerchant,
      'deliveryNoteReceiver': instance.deliveryNoteReceiver,
      'productNote': instance.productNote,
      'otherNotes': instance.otherNotes,
    };

ServiceInformationMap _$ServiceInformationMapFromJson(
        Map<String, dynamic> json) =>
    ServiceInformationMap(
      type: json['type'] == null
          ? null
          : KeyBoolPair.fromJson(json['type'] as Map<String, dynamic>),
      level: json['level'] == null
          ? null
          : KeyBoolPair.fromJson(json['level'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceInformationMapToJson(
        ServiceInformationMap instance) =>
    <String, dynamic>{
      'type': instance.type,
      'level': instance.level,
    };

OtherInformationMap _$OtherInformationMapFromJson(Map<String, dynamic> json) =>
    OtherInformationMap(
      isDangerousGoods: json['isDangerousGoods'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['isDangerousGoods'] as Map<String, dynamic>),
      allowWeekendDelivery: json['allowWeekendDelivery'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['allowWeekendDelivery'] as Map<String, dynamic>),
      requestedDeliveryTimeSlotEndTime:
          json['requestedDeliveryTimeSlotEndTime'] == null
              ? null
              : KeyBoolPair.fromJson(json['requestedDeliveryTimeSlotEndTime']
                  as Map<String, dynamic>),
      cashOnDeliveryAmount: json['cashOnDeliveryAmount'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['cashOnDeliveryAmount'] as Map<String, dynamic>),
      cashOnDeliveryCurrency: json['cashOnDeliveryCurrency'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['cashOnDeliveryCurrency'] as Map<String, dynamic>),
      cashOnDeliveryRequested: json['cashOnDeliveryRequested'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['cashOnDeliveryRequested'] as Map<String, dynamic>),
      insuredAmount: json['insuredAmount'] == null
          ? null
          : KeyBoolPair.fromJson(json['insuredAmount'] as Map<String, dynamic>),
      insuredCurrency: json['insuredCurrency'] == null
          ? null
          : KeyBoolPair.fromJson(
              json['insuredCurrency'] as Map<String, dynamic>),
      requestedDeliveryTimeSlotStartTime:
          json['requestedDeliveryTimeSlotStartTime'] == null
              ? null
              : KeyBoolPair.fromJson(json['requestedDeliveryTimeSlotStartTime']
                  as Map<String, dynamic>),
      requestedDeliveryTimeSlotType: json['requestedDeliveryTimeSlotType'] ==
              null
          ? null
          : KeyBoolPair.fromJson(
              json['requestedDeliveryTimeSlotType'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtherInformationMapToJson(
        OtherInformationMap instance) =>
    <String, dynamic>{
      'isDangerousGoods': instance.isDangerousGoods,
      'allowWeekendDelivery': instance.allowWeekendDelivery,
      'requestedDeliveryTimeSlotType': instance.requestedDeliveryTimeSlotType,
      'requestedDeliveryTimeSlotStartTime':
          instance.requestedDeliveryTimeSlotStartTime,
      'requestedDeliveryTimeSlotEndTime':
          instance.requestedDeliveryTimeSlotEndTime,
      'cashOnDeliveryRequested': instance.cashOnDeliveryRequested,
      'cashOnDeliveryAmount': instance.cashOnDeliveryAmount,
      'cashOnDeliveryCurrency': instance.cashOnDeliveryCurrency,
      'insuredAmount': instance.insuredAmount,
      'insuredCurrency': instance.insuredCurrency,
    };

FilledMappingRequest _$FilledMappingRequestFromJson(
        Map<String, dynamic> json) =>
    FilledMappingRequest(
      id: json['id'] as String?,
      mapping: json['mapping'] == null
          ? null
          : Mapping.fromJson(json['mapping'] as Map<String, dynamic>),
      merchantId: json['merchantId'] as String?,
    );

Map<String, dynamic> _$FilledMappingRequestToJson(
        FilledMappingRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchantId': instance.merchantId,
      'mapping': instance.mapping,
    };
