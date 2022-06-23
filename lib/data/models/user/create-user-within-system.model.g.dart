// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-user-within-system.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserWithinSystem _$CreateUserWithinSystemFromJson(
        Map<String, dynamic> json) =>
    CreateUserWithinSystem(
      id: json['id'] as String?,
      typeOfUserCreated:
          $enumDecode(_$SpecificTypeOfUserEnumMap, json['typeOfUserCreated']),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      phoneNumberCountryCode: json['phoneNumberCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      photoUrl: json['photoUrl'] as String?,
      merchantDetails: json['merchantDetails'] == null
          ? null
          : MerchantDetails.fromJson(
              json['merchantDetails'] as Map<String, dynamic>),
      driverDetails: json['driverDetails'] == null
          ? null
          : DriverDetails.fromJson(
              json['driverDetails'] as Map<String, dynamic>),
      roleId: json['roleId'] as String,
    );

Map<String, dynamic> _$CreateUserWithinSystemToJson(
        CreateUserWithinSystem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'typeOfUserCreated':
          _$SpecificTypeOfUserEnumMap[instance.typeOfUserCreated],
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'phoneNumberCountryCode': instance.phoneNumberCountryCode,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'merchantDetails': instance.merchantDetails?.toJson(),
      'driverDetails': instance.driverDetails?.toJson(),
      'roleId': instance.roleId,
    };

const _$SpecificTypeOfUserEnumMap = {
  SpecificTypeOfUser.LOAD_AND_GO: 'LOAD_AND_GO',
  SpecificTypeOfUser.TENANT: 'TENANT',
  SpecificTypeOfUser.SUB_TENANT: 'SUB_TENANT',
  SpecificTypeOfUser.MERCHANT: 'MERCHANT',
  SpecificTypeOfUser.SUB_MERCHANT: 'SUB_MERCHANT',
  SpecificTypeOfUser.DRIVER: 'DRIVER',
  SpecificTypeOfUser.NOT_APPLICABLE: 'NOT_APPLICABLE',
};

UpdateUserWithinSystem _$UpdateUserWithinSystemFromJson(
        Map<String, dynamic> json) =>
    UpdateUserWithinSystem(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumberCountryCode: json['phoneNumberCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      photoUrl: json['photoUrl'] as String?,
      merchantDetails: json['merchantDetails'] == null
          ? null
          : MerchantDetails.fromJson(
              json['merchantDetails'] as Map<String, dynamic>),
      driverDetails: json['driverDetails'] == null
          ? null
          : DriverDetails.fromJson(
              json['driverDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateUserWithinSystemToJson(
        UpdateUserWithinSystem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumberCountryCode': instance.phoneNumberCountryCode,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'merchantDetails': instance.merchantDetails?.toJson(),
      'driverDetails': instance.driverDetails?.toJson(),
    };
