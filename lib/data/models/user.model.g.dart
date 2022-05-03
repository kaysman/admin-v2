// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserList _$UserListFromJson(Map<String, dynamic> json) => UserList(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserListToJson(UserList instance) => <String, dynamic>{
      'items': instance.items,
      'meta': instance.meta,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      password: json['password'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      photoUrl: json['photoUrl'] as String?,
      roleId: json['roleId'] as String?,
      status: json['status'] as String?,
      merchant: json['merchant'] == null
          ? null
          : MerchantDetails.fromJson(json['merchant'] as Map<String, dynamic>),
      driver: json['driver'] == null
          ? null
          : DriverDetails.fromJson(json['driver'] as Map<String, dynamic>),
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      genericTypeOfUser: $enumDecodeNullable(
          _$GenericTypeOfUserEnumMap, json['genericTypeOfUser']),
      specificTypeOfUser: $enumDecodeNullable(
          _$SpecificTypeOfUserEnumMap, json['specificTypeOfUser']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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
      'specificTypeOfUser':
          _$SpecificTypeOfUserEnumMap[instance.specificTypeOfUser],
      'genericTypeOfUser':
          _$GenericTypeOfUserEnumMap[instance.genericTypeOfUser],
      'merchant': instance.merchant,
      'driver': instance.driver,
      'role': instance.role,
      'tenant': instance.tenant,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$GenericTypeOfUserEnumMap = {
  GenericTypeOfUser.LOAD_AND_GO: 'LOAD_AND_GO',
  GenericTypeOfUser.TENANT: 'TENANT',
  GenericTypeOfUser.MERCHANT: 'MERCHANT',
  GenericTypeOfUser.DRIVER: 'DRIVER',
  GenericTypeOfUser.RECEIVER: 'RECEIVER',
  GenericTypeOfUser.NOT_APPLICABLE: 'NOT_APPLICABLE',
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
