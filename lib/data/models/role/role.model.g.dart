// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleList _$RoleListFromJson(Map<String, dynamic> json) => RoleList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoleListToJson(RoleList instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: json['id'] as String?,
      name: $enumDecodeNullable(_$RoleTypeEnumMap, json['name']),
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': _$RoleTypeEnumMap[instance.name],
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'permissions': instance.permissions,
      'tenant': instance.tenant,
    };

const _$RoleTypeEnumMap = {
  RoleType.LOAD_AND_GO: 'LOAD_AND_GO',
  RoleType.TENANT: 'TENANT',
  RoleType.MERCHANT: 'MERCHANT',
  RoleType.DRIVER: 'DRIVER',
  RoleType.RECEIVER: 'RECEIVER',
};
