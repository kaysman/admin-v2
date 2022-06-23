// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update-tenant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTenantRequest _$UpdateTenantRequestFromJson(Map<String, dynamic> json) =>
    UpdateTenantRequest(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactName: json['contactName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      phoneNumberCountryCode: json['phoneNumberCountryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      vat: json['vat'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateTenantRequestToJson(
        UpdateTenantRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'phoneNumberCountryCode': instance.phoneNumberCountryCode,
      'phoneNumber': instance.phoneNumber,
      'vat': instance.vat,
      'address': instance.address,
    };
