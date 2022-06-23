// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamList _$TeamListFromJson(Map<String, dynamic> json) => TeamList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamListToJson(TeamList instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      warehouse: json['warehouse'],
      drivers: json['drivers'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'warehouse': instance.warehouse,
      'drivers': instance.drivers,
    };
