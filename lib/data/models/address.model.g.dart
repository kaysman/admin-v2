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
      typeOfContactForAddress: $enumDecodeNullable(
          _$TypeOfContactForAddressEnumMap, json['typeOfContactForAddress']),
      specificTypeOfLocation: $enumDecodeNullable(
          _$SpecificTypeOfLocationEnumMap, json['specificTypeOfLocation']),
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
      'specificTypeOfLocation':
          _$SpecificTypeOfLocationEnumMap[instance.specificTypeOfLocation],
      'typeOfContactForAddress':
          _$TypeOfContactForAddressEnumMap[instance.typeOfContactForAddress],
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$AddressTypeEnumMap = {
  AddressType.HOME: 'HOME',
  AddressType.OFFICE: 'OFFICE',
  AddressType.WAREHOUSE: 'WAREHOUSE',
};

const _$TypeOfContactForAddressEnumMap = {
  TypeOfContactForAddress.TENANT: 'TENANT',
  TypeOfContactForAddress.MERCHANT: 'MERCHANT',
  TypeOfContactForAddress.WAREHOUSE: 'WAREHOUSE',
  TypeOfContactForAddress.DISPATCH_POINT: 'DISPATCH_POINT',
  TypeOfContactForAddress.DRIVER: 'DRIVER',
  TypeOfContactForAddress.SENDER: 'SENDER',
  TypeOfContactForAddress.RECEIVER: 'RECEIVER',
  TypeOfContactForAddress.OTHER: 'OTHER',
  TypeOfContactForAddress.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
};

const _$SpecificTypeOfLocationEnumMap = {
  SpecificTypeOfLocation.TENANT_PROFILE_DEFAULT: 'TENANT_PROFILE_DEFAULT',
  SpecificTypeOfLocation.MERCHANT_PROFILE_DEFAULT: 'MERCHANT_PROFILE_DEFAULT',
  SpecificTypeOfLocation.DRIVER_PROFILE_DEFAULT: 'DRIVER_PROFILE_DEFAULT',
  SpecificTypeOfLocation.LNG_TECH_TEAM_GENERATED: 'LNG_TECH_TEAM_GENERATED',
  SpecificTypeOfLocation.TENANT_WAREHOUSE: 'TENANT_WAREHOUSE',
  SpecificTypeOfLocation.TENANT_DISPATCH_POINT: 'TENANT_DISPATCH_POINT',
  SpecificTypeOfLocation.MERCHANT_ANY_LOCATION: 'MERCHANT_ANY_LOCATION',
  SpecificTypeOfLocation.DRIVER_PROFILE_LOCATION: 'DRIVER_PROFILE_LOCATION',
  SpecificTypeOfLocation.SENDER_ADDRESS: 'SENDER_ADDRESS',
  SpecificTypeOfLocation.RECEIVER_ADDRESS: 'RECEIVER_ADDRESS',
  SpecificTypeOfLocation.SPECIFIC_FOR_ONE_PICK_UP_TASK:
      'SPECIFIC_FOR_ONE_PICK_UP_TASK',
  SpecificTypeOfLocation.SPECIFIC_FOR_ONE_DROP_OFF_TASK:
      'SPECIFIC_FOR_ONE_DROP_OFF_TASK',
  SpecificTypeOfLocation.CUSTOM_TASK_RELATED: 'CUSTOM_TASK_RELATED',
  SpecificTypeOfLocation.CUSTOM_NOT_TASK_RELATED: 'CUSTOM_NOT_TASK_RELATED',
  SpecificTypeOfLocation.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
  SpecificTypeOfLocation.DRIVER_ROUTE_STARTING_POINT:
      'DRIVER_ROUTE_STARTING_POINT',
  SpecificTypeOfLocation.DRIVER_ROUTE_ENDING_POINT: 'DRIVER_ROUTE_ENDING_POINT',
  SpecificTypeOfLocation.NOT_APPLICABLE: 'NOT_APPLICABLE',
};
