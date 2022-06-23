// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle-details.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleDetail _$VehicleDetailFromJson(Map<String, dynamic> json) =>
    VehicleDetail(
      id: json['id'] as String?,
      color: json['color'] as String?,
      year: json['year'] as String?,
      model: json['model'] as String?,
      licensePlate: json['licensePlate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$VehicleDetailToJson(VehicleDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'year': instance.year,
      'model': instance.model,
      'licensePlate': instance.licensePlate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
