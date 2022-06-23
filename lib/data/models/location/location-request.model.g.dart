// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationRequest _$LocationRequestFromJson(Map<String, dynamic> json) =>
    LocationRequest(
      id: json['id'] as String?,
      size: json['size'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$WarehouseTypeEnumMap, json['type']),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      contactDetails: ContactDetail.fromJson(
          json['contactDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationRequestToJson(LocationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'size': instance.size,
      'type': _$WarehouseTypeEnumMap[instance.type],
      'address': instance.address,
      'contactDetails': instance.contactDetails,
    };

const _$WarehouseTypeEnumMap = {
  WarehouseType.WAREHOUSE: 'WAREHOUSE',
  WarehouseType.DISPATCH_POINT: 'DISPATCH_POINT',
};
