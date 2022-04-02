// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_timeline.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTimeline _$OrderTimelineFromJson(Map<String, dynamic> json) =>
    OrderTimeline(
      id: json['id'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrderTimelineToJson(OrderTimeline instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
