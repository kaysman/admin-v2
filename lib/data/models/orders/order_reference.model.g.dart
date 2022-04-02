// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_reference.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderReference _$OrderReferenceFromJson(Map<String, dynamic> json) =>
    OrderReference(
      merchantOrderNumber: json['merchantOrderNumber'] as String?,
      others: json['others'] as String?,
    );

Map<String, dynamic> _$OrderReferenceToJson(OrderReference instance) =>
    <String, dynamic>{
      'merchantOrderNumber': instance.merchantOrderNumber,
      'others': instance.others,
    };
