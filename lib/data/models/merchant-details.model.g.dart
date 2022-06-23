// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant-details.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantDetails _$MerchantDetailsFromJson(Map<String, dynamic> json) =>
    MerchantDetails(
      id: json['id'] as String?,
      companyName: json['companyName'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      contactName: json['contactName'] as String,
      contactEmail: json['contactEmail'] as String,
      phoneNumber: json['phoneNumber'] as String,
      phoneNumberCountryCode: json['phoneNumberCountryCode'] as String?,
      vat: json['vat'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      trackingEmail: json['trackingEmail'] as String?,
      trackingPhoneNumber: json['trackingPhoneNumber'] as String?,
    );

Map<String, dynamic> _$MerchantDetailsToJson(MerchantDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'address': instance.address?.toJson(),
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberCountryCode': instance.phoneNumberCountryCode,
      'trackingPhoneNumber': instance.trackingPhoneNumber,
      'trackingEmail': instance.trackingEmail,
      'vat': instance.vat,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
