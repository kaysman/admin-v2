// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SenderDetail _$SenderDetailFromJson(Map<String, dynamic> json) => SenderDetail(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      company: json['company'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SenderDetailToJson(SenderDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'company': instance.company,
      'address': instance.address,
    };
