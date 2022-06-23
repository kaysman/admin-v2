// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationOptions _$PaginationOptionsFromJson(Map<String, dynamic> json) =>
    PaginationOptions(
      sortOrder: $enumDecodeNullable(
              _$PaginationSortOrderEnumMap, json['sortOrder']) ??
          PaginationSortOrder.DESC,
      sortBy: json['sortBy'] as String?,
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      filter: json['filter'] as String?,
      roleId: json['roleId'] as String?,
      status: json['status'] as String?,
      skip: json['skip'] as int?,
    );

Map<String, dynamic> _$PaginationOptionsToJson(PaginationOptions instance) =>
    <String, dynamic>{
      'sortOrder': _$PaginationSortOrderEnumMap[instance.sortOrder],
      'sortBy': instance.sortBy,
      'page': instance.page,
      'limit': instance.limit,
      'filter': instance.filter,
      'roleId': instance.roleId,
      'status': instance.status,
      'skip': instance.skip,
    };

const _$PaginationSortOrderEnumMap = {
  PaginationSortOrder.ASC: 'ASC',
  PaginationSortOrder.DESC: 'DESC',
};
