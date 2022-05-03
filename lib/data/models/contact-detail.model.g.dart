// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact-detail.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetail _$ContactDetailFromJson(Map<String, dynamic> json) =>
    ContactDetail(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      emailAddress: json['emailAddress'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      company: json['company'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      typeOfOtherContactDetail: $enumDecodeNullable(
          _$TypeOfOtherContactDetailEnumMap, json['typeOfOtherContactDetail']),
    );

Map<String, dynamic> _$ContactDetailToJson(ContactDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'emailAddress': instance.emailAddress,
      'phoneNumber': instance.phoneNumber,
      'company': instance.company,
      'address': instance.address,
      'typeOfOtherContactDetail':
          _$TypeOfOtherContactDetailEnumMap[instance.typeOfOtherContactDetail],
    };

const _$TypeOfOtherContactDetailEnumMap = {
  TypeOfOtherContactDetail.WAREHOUSE: 'WAREHOUSE',
  TypeOfOtherContactDetail.DISPATCH_POINT: 'DISPATCH_POINT',
  TypeOfOtherContactDetail.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
  TypeOfOtherContactDetail.OTHERS: 'OTHERS',
};
