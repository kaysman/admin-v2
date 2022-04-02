// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-pickup-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePickupRequest _$CreatePickupRequestFromJson(Map<String, dynamic> json) =>
    CreatePickupRequest(
      type: json['type'] as String?,
      numberOfItems: json['numberOfItems'] as int?,
      weight: json['weight'] as int?,
      pickupTimeWindowStart: json['pickupTimeWindowStart'] as String?,
      pickupTimeWindowEnd: json['pickupTimeWindowEnd'] as String?,
    );

Map<String, dynamic> _$CreatePickupRequestToJson(
        CreatePickupRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'numberOfItems': instance.numberOfItems,
      'weight': instance.weight,
      'pickupTimeWindowStart': instance.pickupTimeWindowStart,
      'pickupTimeWindowEnd': instance.pickupTimeWindowEnd,
    };
