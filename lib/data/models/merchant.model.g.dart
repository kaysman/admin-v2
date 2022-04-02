// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchant _$MerchantFromJson(Map<String, dynamic> json) => Merchant(
      id: json['id'] as String?,
      companyName: json['companyName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactName: json['contactName'] as String?,
      createdAt: json['createdAt'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phoneNumber: json['phoneNumber'] as String?,
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] as String?,
      vat: json['vat'] as String?,
    );

Map<String, dynamic> _$MerchantToJson(Merchant instance) => <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'vat': instance.vat,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
