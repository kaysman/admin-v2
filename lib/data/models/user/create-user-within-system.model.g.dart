// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-user-within-system.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserWithinSystem _$CreateUserWithinSystemFromJson(
        Map<String, dynamic> json) =>
    CreateUserWithinSystem(
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
