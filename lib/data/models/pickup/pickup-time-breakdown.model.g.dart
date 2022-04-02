// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup-time-breakdown.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupTimeBreakDown _$PickupTimeBreakDownFromJson(Map<String, dynamic> json) =>
    PickupTimeBreakDown(
      date: json['date'] as String?,
      pickupTime: json['pickupTime'] as String?,
      closingTime: json['closingTime'] as String?,
    );

Map<String, dynamic> _$PickupTimeBreakDownToJson(
        PickupTimeBreakDown instance) =>
    <String, dynamic>{
      'date': instance.date,
      'pickupTime': instance.pickupTime,
      'closingTime': instance.closingTime,
    };
