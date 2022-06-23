// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      totalItems: json['totalItems'] as int?,
      itemCount: json['itemCount'] as int?,
      itemsPerPage: json['itemsPerPage'] as int?,
      currentPage: json['currentPage'] as int? ?? 1,
      totalPages: json['totalPages'] as int?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'totalItems': instance.totalItems,
      'itemCount': instance.itemCount,
      'itemsPerPage': instance.itemsPerPage,
      'totalPages': instance.totalPages,
      'currentPage': instance.currentPage,
    };
