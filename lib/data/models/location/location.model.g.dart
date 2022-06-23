// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationList _$LocationListFromJson(Map<String, dynamic> json) => LocationList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LocationListToJson(LocationList instance) =>
    <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: $enumDecodeNullable(_$WarehouseTypeEnumMap, json['type']),
      size: json['size'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$WarehouseTypeEnumMap[instance.type],
      'size': instance.size,
      'address': instance.address,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$WarehouseTypeEnumMap = {
  WarehouseType.WAREHOUSE: 'WAREHOUSE',
  WarehouseType.DISPATCH_POINT: 'DISPATCH_POINT',
};
