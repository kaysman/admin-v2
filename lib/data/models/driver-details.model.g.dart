// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver-details.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDetails _$DriverDetailsFromJson(Map<String, dynamic> json) =>
    DriverDetails(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      vehicleType: json['vehicleType'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      vehicleDetail: json['vehicleDetail'] == null
          ? null
          : VehicleDetail.fromJson(
              json['vehicleDetail'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DriverDetailsToJson(DriverDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleType': instance.vehicleType,
      'address': instance.address,
      'vehicleDetail': instance.vehicleDetail,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
