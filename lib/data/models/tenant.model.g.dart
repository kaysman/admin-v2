// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tenant _$TenantFromJson(Map<String, dynamic> json) => Tenant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      contactName: json['contactName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      updatedAt: json['updatedAt'] as String?,
      vat: json['vat'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TenantToJson(Tenant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactName': instance.contactName,
      'contactEmail': instance.contactEmail,
      'phoneNumber': instance.phoneNumber,
      'vat': instance.vat,
      'address': instance.address,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
