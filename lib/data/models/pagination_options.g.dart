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
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
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
      'status': _$StatusEnumMap[instance.status],
      'skip': instance.skip,
    };

const _$PaginationSortOrderEnumMap = {
  PaginationSortOrder.ASC: 'ASC',
  PaginationSortOrder.DESC: 'DESC',
};

const _$StatusEnumMap = {
  Status.ORDER_CREATED: 'ORDER_CREATED',
  Status.AWB_PRINTED: 'AWB_PRINTED',
  Status.SHIPPING_LABEL_PRINTED: 'SHIPPING_LABEL_PRINTED',
  Status.READY_FOR_PICK_UP: 'READY_FOR_PICK_UP',
  Status.PICK_UP_CONFIRMED: 'PICK_UP_CONFIRMED',
  Status.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  Status.IN_WAREHOUSE_FOR_SORTING: 'IN_WAREHOUSE_FOR_SORTING',
  Status.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  Status.ON_VEHICLE_FOR_DELIVERY: 'ON_VEHICLE_FOR_DELIVERY',
  Status.ORDER_COMPLETED: 'ORDER_COMPLETED',
  Status.FAILED_PICK_UP: 'FAILED_PICK_UP',
  Status.DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  Status.DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  Status.DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  Status.DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER',
  Status.DELIVERY_ENDED_RETURNED_TO_SENDER: 'DELIVERY_ENDED_RETURNED_TO_SENDER',
  Status.CUSTOM: 'CUSTOM',
};
