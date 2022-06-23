import 'package:json_annotation/json_annotation.dart';
part 'mapping-response.model.g.dart';

@JsonSerializable()
class MappingResponse {
  MappingResponse({
    this.id,
    this.count,
    this.headers,
    this.mapping,
  });

  String? id;
  int? count;
  List<String>? headers;
  Mapping? mapping;

  factory MappingResponse.fromJson(Map<String, dynamic> json) =>
      _$MappingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MappingResponseToJson(this);
}

@JsonSerializable()
class Mapping {
  Mapping({
    this.orderInformation,
    this.receiverInformation,
    this.senderInformation,
    this.notes,
    this.otherInformation,
    this.serviceInformation,
  });

  ServiceInformationMap? serviceInformation;
  DataMap? senderInformation;
  DataMap? receiverInformation;
  NoteMap? notes;
  OrderDetails? orderInformation;
  OtherInformationMap? otherInformation;

  factory Mapping.fromJson(Map<String, dynamic> json) =>
      _$MappingFromJson(json);

  Map<String, dynamic> toJson() => _$MappingToJson(this);
}

@JsonSerializable()
class DataMap {
  DataMap({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.company,
    this.addressLineOne,
    this.addressLineThree,
    this.addressLineTwo,
    this.addressType,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.postalCode,
  });

  KeyBoolPair? firstName;
  KeyBoolPair? lastName;
  KeyBoolPair? emailAddress;
  KeyBoolPair? phoneNumber;
  KeyBoolPair? company;
  KeyBoolPair? addressLineOne;
  KeyBoolPair? addressLineTwo;
  KeyBoolPair? addressLineThree;
  KeyBoolPair? postalCode;
  KeyBoolPair? city;
  KeyBoolPair? country;
  KeyBoolPair? longitude;
  KeyBoolPair? latitude;
  KeyBoolPair? addressType;

  factory DataMap.fromJson(Map<String, dynamic> json) =>
      _$DataMapFromJson(json);

  Map<String, dynamic> toJson() => _$DataMapToJson(this);
}

@JsonSerializable()
class KeyBoolPair {
  KeyBoolPair({
    this.isRequired,
    this.key,
  });

  bool? isRequired;
  dynamic key;
  factory KeyBoolPair.fromJson(Map<String, dynamic> json) =>
      _$KeyBoolPairFromJson(json);

  Map<String, dynamic> toJson() => _$KeyBoolPairToJson(this);
}

@JsonSerializable()
class OrderDetails {
  OrderDetails({
    this.orderNumber,
    this.description,
    this.quantity,
    this.weight,
    this.currency,
    this.dimensionUnit,
    this.height,
    this.length,
    this.name,
    this.price,
    this.type,
    this.weightUnit,
    this.width,
  });

  final KeyBoolPair? name;
  final KeyBoolPair? orderNumber;
  final KeyBoolPair? description;
  final KeyBoolPair? currency;
  final KeyBoolPair? dimensionUnit;
  final KeyBoolPair? height;
  final KeyBoolPair? length;
  final KeyBoolPair? price;
  final KeyBoolPair? quantity;
  final KeyBoolPair? type;
  final KeyBoolPair? width;
  final KeyBoolPair? weight;
  final KeyBoolPair? weightUnit;

  factory OrderDetails.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsToJson(this);
}

@JsonSerializable()
class NoteMap {
  NoteMap({
    this.deliveryNoteMerchant,
    this.deliveryNoteReceiver,
    this.otherNotes,
    this.pickupNote,
    this.productNote,
  });

  final KeyBoolPair? pickupNote;
  final KeyBoolPair? deliveryNoteMerchant;
  final KeyBoolPair? deliveryNoteReceiver;
  final KeyBoolPair? productNote;
  final KeyBoolPair? otherNotes;

  factory NoteMap.fromJson(Map<String, dynamic> json) =>
      _$NoteMapFromJson(json);

  Map<String, dynamic> toJson() => _$NoteMapToJson(this);
}

@JsonSerializable()
class ServiceInformationMap {
  ServiceInformationMap({
    this.type,
    this.level,
  });

  final KeyBoolPair? type;
  final KeyBoolPair? level;

  factory ServiceInformationMap.fromJson(Map<String, dynamic> json) =>
      _$ServiceInformationMapFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceInformationMapToJson(this);
}

@JsonSerializable()
class OtherInformationMap {
  OtherInformationMap({
    this.isDangerousGoods,
    this.allowWeekendDelivery,
    this.requestedDeliveryTimeSlotEndTime,
    this.cashOnDeliveryAmount,
    this.cashOnDeliveryCurrency,
    this.cashOnDeliveryRequested,
    this.insuredAmount,
    this.insuredCurrency,
    this.requestedDeliveryTimeSlotStartTime,
    this.requestedDeliveryTimeSlotType,
  });

  final KeyBoolPair? isDangerousGoods;
  final KeyBoolPair? allowWeekendDelivery;
  final KeyBoolPair? requestedDeliveryTimeSlotType;
  final KeyBoolPair? requestedDeliveryTimeSlotStartTime;
  final KeyBoolPair? requestedDeliveryTimeSlotEndTime;
  final KeyBoolPair? cashOnDeliveryRequested;
  final KeyBoolPair? cashOnDeliveryAmount;
  final KeyBoolPair? cashOnDeliveryCurrency;
  final KeyBoolPair? insuredAmount;
  final KeyBoolPair? insuredCurrency;

  factory OtherInformationMap.fromJson(Map<String, dynamic> json) =>
      _$OtherInformationMapFromJson(json);

  Map<String, dynamic> toJson() => _$OtherInformationMapToJson(this);
}

@JsonSerializable()
class FilledMappingRequest {
  FilledMappingRequest({
    this.id,
    this.mapping,
    this.merchantId,
  });

  String? id;
  String? merchantId;
  Mapping? mapping;

  factory FilledMappingRequest.fromJson(Map<String, dynamic> json) =>
      _$FilledMappingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FilledMappingRequestToJson(this);
}
