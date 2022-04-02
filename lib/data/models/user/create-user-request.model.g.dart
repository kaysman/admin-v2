// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-user-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    CreateUserRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      password: json['password'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      roleId: json['roleId'] as String?,
      status: json['status'] as String?,
      merchantDetails: json['merchantDetails'] == null
          ? null
          : MerchantDetails.fromJson(
              json['merchantDetails'] as Map<String, dynamic>),
      driverDetails: json['driverDetails'] == null
          ? null
          : DriverDetails.fromJson(
              json['driverDetails'] as Map<String, dynamic>),
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CreateUserRequestToJson(CreateUserRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'photoUrl': instance.photoUrl,
      'roleId': instance.roleId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'merchantDetails': instance.merchantDetails,
      'driverDetails': instance.driverDetails,
    };
