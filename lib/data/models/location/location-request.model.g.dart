// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationRequest _$LocationRequestFromJson(Map<String, dynamic> json) =>
    LocationRequest(
      id: json['id'] as String?,
      size: json['size'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationRequestToJson(LocationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'size': instance.size,
      'address': instance.address,
    };
