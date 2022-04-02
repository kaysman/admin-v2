// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      addressLineOne: json['addressLineOne'] as String?,
      addressLineTwo: json['addressLineTwo'] as String?,
      addressLineThree: json['addressLineThree'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      createdAt: json['createdAt'] as String?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
      updatedAt: json['updatedAt'] as String?,
      addressType:
          $enumDecodeNullable(_$AddressTypeEnumMap, json['addressType']),
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'addressLineOne': instance.addressLineOne,
      'addressLineTwo': instance.addressLineTwo,
      'addressLineThree': instance.addressLineThree,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'addressType': _$AddressTypeEnumMap[instance.addressType],
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$AddressTypeEnumMap = {
  AddressType.HOME: 'HOME',
  AddressType.OFFICE: 'OFFICE',
  AddressType.WAREHOUSE: 'WAREHOUSE',
};
