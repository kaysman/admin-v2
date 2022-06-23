// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver-details.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverDetails _$DriverDetailsFromJson(Map<String, dynamic> json) =>
    DriverDetails(
      id: json['id'] as String?,
      vehicleType: $enumDecode(_$VehicleTypeEnumMap, json['vehicleType']),
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      vehicleDetail:
          VehicleDetail.fromJson(json['vehicleDetail'] as Map<String, dynamic>),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DriverDetailsToJson(DriverDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicleType': _$VehicleTypeEnumMap[instance.vehicleType],
      'address': instance.address?.toJson(),
      'vehicleDetail': instance.vehicleDetail.toJson(),
      'description': instance.description,
    };

const _$VehicleTypeEnumMap = {
  VehicleType.WALKER: 'WALKER',
  VehicleType.CYCLIST: 'CYCLIST',
  VehicleType.MOTORBIKE: 'MOTORBIKE',
  VehicleType.CAR: 'CAR',
  VehicleType.VAN: 'VAN',
  VehicleType.FOOTER_14: 'FOOTER_14',
  VehicleType.FOOTER_24: 'FOOTER_24',
  VehicleType.OTHERS: 'OTHERS',
};
