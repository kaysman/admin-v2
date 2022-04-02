// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupList _$PickupListFromJson(Map<String, dynamic> json) => PickupList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Pickup.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PickupListToJson(PickupList instance) =>
    <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Pickup _$PickupFromJson(Map<String, dynamic> json) => Pickup(
      id: json['id'] as String?,
      type: json['type'] as String?,
      merchant: json['merchant'] == null
          ? null
          : Merchant.fromJson(json['merchant'] as Map<String, dynamic>),
      status: json['status'] as String?,
      numberOfItems: json['numberOfItems'] as int?,
      weight: (json['weight'] as num?)?.toDouble(),
      pickupTimeWindowStart: json['pickupTimeWindowStart'] == null
          ? null
          : DateTime.parse(json['pickupTimeWindowStart'] as String),
      pickupTimeWindowEnd: json['pickupTimeWindowEnd'] == null
          ? null
          : DateTime.parse(json['pickupTimeWindowEnd'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PickupToJson(Pickup instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'status': instance.status,
      'numberOfItems': instance.numberOfItems,
      'weight': instance.weight,
      'merchant': instance.merchant,
      'pickupTimeWindowStart':
          instance.pickupTimeWindowStart?.toIso8601String(),
      'pickupTimeWindowEnd': instance.pickupTimeWindowEnd?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
