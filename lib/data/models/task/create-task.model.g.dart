// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-task.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTaskEntity _$CreateTaskEntityFromJson(Map<String, dynamic> json) =>
    CreateTaskEntity(
      relationToWhichSpecificTaskRelatedStatus: $enumDecode(
          _$TaskRelatedWorkflowStepsEnumMap,
          json['relationToWhichSpecificTaskRelatedStatus']),
      startTimeForPickUp: json['startTimeForPickUp'] as String,
      endTimeForPickUp: json['endTimeForPickUp'] as String,
      genericTypeOfAddressForPickUp: $enumDecodeNullable(
          _$GenericTypeOfLocationEnumMap,
          json['genericTypeOfAddressForPickUp']),
      addressIdIfExistingForPickUp:
          json['addressIdIfExistingForPickUp'] as String?,
      addressAndContactIfNewForPickUp:
          json['addressAndContactIfNewForPickUp'] == null
              ? null
              : AddressWithOtherContactDetails.fromJson(
                  json['addressAndContactIfNewForPickUp']
                      as Map<String, dynamic>),
      startTimeForDropOff: json['startTimeForDropOff'] as String?,
      endTimeForDropOff: json['endTimeForDropOff'] as String?,
      genericTypeOfAddressForDropOff: $enumDecodeNullable(
          _$GenericTypeOfLocationEnumMap,
          json['genericTypeOfAddressForDropOff']),
      addressIdIfExistingForDropOff:
          json['addressIdIfExistingForDropOff'] as String?,
      addressAndContactIfNewForDropOff:
          json['addressAndContactIfNewForDropOff'] == null
              ? null
              : AddressWithOtherContactDetails.fromJson(
                  json['addressAndContactIfNewForDropOff']
                      as Map<String, dynamic>),
      driverId: json['driverId'] as String,
      orderIds: (json['orderIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateTaskEntityToJson(CreateTaskEntity instance) =>
    <String, dynamic>{
      'relationToWhichSpecificTaskRelatedStatus':
          _$TaskRelatedWorkflowStepsEnumMap[
              instance.relationToWhichSpecificTaskRelatedStatus],
      'startTimeForPickUp': instance.startTimeForPickUp,
      'endTimeForPickUp': instance.endTimeForPickUp,
      'genericTypeOfAddressForPickUp': _$GenericTypeOfLocationEnumMap[
          instance.genericTypeOfAddressForPickUp],
      'addressIdIfExistingForPickUp': instance.addressIdIfExistingForPickUp,
      'addressAndContactIfNewForPickUp':
          instance.addressAndContactIfNewForPickUp?.toJson(),
      'startTimeForDropOff': instance.startTimeForDropOff,
      'endTimeForDropOff': instance.endTimeForDropOff,
      'genericTypeOfAddressForDropOff': _$GenericTypeOfLocationEnumMap[
          instance.genericTypeOfAddressForDropOff],
      'addressIdIfExistingForDropOff': instance.addressIdIfExistingForDropOff,
      'addressAndContactIfNewForDropOff':
          instance.addressAndContactIfNewForDropOff?.toJson(),
      'orderIds': instance.orderIds,
      'driverId': instance.driverId,
    };

const _$TaskRelatedWorkflowStepsEnumMap = {
  TaskRelatedWorkflowSteps.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  TaskRelatedWorkflowSteps.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY: 'ON_VEHICLE_FOR_DELIVERY',
  TaskRelatedWorkflowSteps.CUSTOM_TASK_RELATED: 'CUSTOM_TASK_RELATED',
};

const _$GenericTypeOfLocationEnumMap = {
  GenericTypeOfLocation.TENANT_WAREHOUSE: 'TENANT_WAREHOUSE',
  GenericTypeOfLocation.TENANT_DISPATCH_POINT: 'TENANT_DISPATCH_POINT',
  GenericTypeOfLocation.RECEIVER_ADDRESS: 'RECEIVER_ADDRESS',
  GenericTypeOfLocation.SPECIFIC_FOR_ONE_PICK_UP_TASK:
      'SPECIFIC_FOR_ONE_PICK_UP_TASK',
  GenericTypeOfLocation.SPECIFIC_FOR_ONE_DROP_OFF_TASK:
      'SPECIFIC_FOR_ONE_DROP_OFF_TASK',
  GenericTypeOfLocation.CUSTOM_TASK_RELATED: 'CUSTOM_TASK_RELATED',
  GenericTypeOfLocation.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
  GenericTypeOfLocation.OTHERS: 'OTHERS',
};

AddressWithOtherContactDetails _$AddressWithOtherContactDetailsFromJson(
        Map<String, dynamic> json) =>
    AddressWithOtherContactDetails(
      typeOfContactForAddress: $enumDecode(
          _$TypeOfContactForAddressEnumMap, json['typeOfContactForAddress']),
      addressLineOne: json['addressLineOne'] as String,
      addressLineTwo: json['addressLineTwo'] as String?,
      addressLineThree: json['addressLineThree'] as String?,
      postalCode: json['postalCode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
      addressType:
          $enumDecodeNullable(_$AddressTypeEnumMap, json['addressType']),
      longitute: json['longitute'] as String?,
      latitude: json['latitude'] as String?,
      specificTypeOfLocation: $enumDecode(
          _$SpecificTypeOfLocationEnumMap, json['specificTypeOfLocation']),
      otherContactDetail: ContactDetail.fromJson(
          json['otherContactDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressWithOtherContactDetailsToJson(
        AddressWithOtherContactDetails instance) =>
    <String, dynamic>{
      'typeOfContactForAddress':
          _$TypeOfContactForAddressEnumMap[instance.typeOfContactForAddress],
      'addressLineOne': instance.addressLineOne,
      'addressLineTwo': instance.addressLineTwo,
      'addressLineThree': instance.addressLineThree,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'countryCode': instance.countryCode,
      'addressType': _$AddressTypeEnumMap[instance.addressType],
      'longitute': instance.longitute,
      'latitude': instance.latitude,
      'specificTypeOfLocation':
          _$SpecificTypeOfLocationEnumMap[instance.specificTypeOfLocation],
      'otherContactDetail': instance.otherContactDetail.toJson(),
    };

const _$TypeOfContactForAddressEnumMap = {
  TypeOfContactForAddress.TENANT: 'TENANT',
  TypeOfContactForAddress.MERCHANT: 'MERCHANT',
  TypeOfContactForAddress.WAREHOUSE: 'WAREHOUSE',
  TypeOfContactForAddress.DISPATCH_POINT: 'DISPATCH_POINT',
  TypeOfContactForAddress.DRIVER: 'DRIVER',
  TypeOfContactForAddress.SENDER: 'SENDER',
  TypeOfContactForAddress.RECEIVER: 'RECEIVER',
  TypeOfContactForAddress.OTHER: 'OTHER',
  TypeOfContactForAddress.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
};

const _$AddressTypeEnumMap = {
  AddressType.HOME: 'HOME',
  AddressType.OFFICE: 'OFFICE',
  AddressType.WAREHOUSE: 'WAREHOUSE',
};

const _$SpecificTypeOfLocationEnumMap = {
  SpecificTypeOfLocation.LNG_TECH_TEAM_GENERATED: 'LNG_TECH_TEAM_GENERATED',
  SpecificTypeOfLocation.TENANT_WAREHOUSE: 'TENANT_WAREHOUSE',
  SpecificTypeOfLocation.TENANT_DISPATCH_POINT: 'TENANT_DISPATCH_POINT',
  SpecificTypeOfLocation.MERCHANT_ANY_LOCATION: 'MERCHANT_ANY_LOCATION',
  SpecificTypeOfLocation.DRIVER_PROFILE_LOCATION: 'DRIVER_PROFILE_LOCATION',
  SpecificTypeOfLocation.SENDER_ADDRESS: 'SENDER_ADDRESS',
  SpecificTypeOfLocation.RECEIVER_ADDRESS: 'RECEIVER_ADDRESS',
  SpecificTypeOfLocation.SPECIFIC_FOR_ONE_PICK_UP_TASK:
      'SPECIFIC_FOR_ONE_PICK_UP_TASK',
  SpecificTypeOfLocation.SPECIFIC_FOR_ONE_DROP_OFF_TASK:
      'SPECIFIC_FOR_ONE_DROP_OFF_TASK',
  SpecificTypeOfLocation.CUSTOM_TASK_RELATED: 'CUSTOM_TASK_RELATED',
  SpecificTypeOfLocation.CUSTOM_NOT_TASK_RELATED: 'CUSTOM_NOT_TASK_RELATED',
  SpecificTypeOfLocation.CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP:
      'CUSTOM_FOR_DRIVER_DELIVERY_PICK_UP',
  SpecificTypeOfLocation.NOT_APPLICABLE: 'NOT_APPLICABLE',
};
