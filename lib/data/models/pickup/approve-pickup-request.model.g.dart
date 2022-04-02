// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve-pickup-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveRequestModel _$ApproveRequestModelFromJson(Map<String, dynamic> json) =>
    ApproveRequestModel(
      requestId: json['requestId'] as String?,
      driverId: json['driverId'] as String?,
      pickupTimeWindowStart: json['pickupTimeWindowStart'] as String?,
      pickupTimeWindowEnd: json['pickupTimeWindowEnd'] as String?,
    );

Map<String, dynamic> _$ApproveRequestModelToJson(
        ApproveRequestModel instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'driverId': instance.driverId,
      'pickupTimeWindowStart': instance.pickupTimeWindowStart,
      'pickupTimeWindowEnd': instance.pickupTimeWindowEnd,
    };
