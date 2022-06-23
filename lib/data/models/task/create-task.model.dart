import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';

import '../contact-detail.model.dart';

part 'create-task.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateTaskEntity {
  final TaskRelatedWorkflowSteps relationToWhichSpecificTaskRelatedStatus;
  // pick-up details
  final String startTimeForPickUp;
  final String endTimeForPickUp;
  final GenericTypeOfLocation? genericTypeOfAddressForPickUp;
  final String? addressIdIfExistingForPickUp;
  final AddressWithOtherContactDetails? addressAndContactIfNewForPickUp;
  // drop-off details
  final String? startTimeForDropOff;
  final String? endTimeForDropOff;
  final GenericTypeOfLocation? genericTypeOfAddressForDropOff;
  final String? addressIdIfExistingForDropOff;
  final AddressWithOtherContactDetails? addressAndContactIfNewForDropOff;

  final List<String>? orderIds;
  final String driverId;

  CreateTaskEntity({
    required this.relationToWhichSpecificTaskRelatedStatus,
    required this.startTimeForPickUp,
    required this.endTimeForPickUp,
    this.genericTypeOfAddressForPickUp,
    this.addressIdIfExistingForPickUp,
    this.addressAndContactIfNewForPickUp,
    this.startTimeForDropOff,
    this.endTimeForDropOff,
    this.genericTypeOfAddressForDropOff,
    this.addressIdIfExistingForDropOff,
    this.addressAndContactIfNewForDropOff,
    required this.driverId,
    this.orderIds,
  });

  factory CreateTaskEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateTaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTaskEntityToJson(this);

  @override
  String toString() {
    return 'CreateTaskEntity(relationToWhichSpecificTaskRelatedStatus: $relationToWhichSpecificTaskRelatedStatus, startTimeForPickUp: $startTimeForPickUp, endTimeForPickUp: $endTimeForPickUp, genericTypeOfAddressForPickUp: $genericTypeOfAddressForPickUp, addressIdIfExistingForPickUp: $addressIdIfExistingForPickUp, addressAndContactIfNewForPickUp: $addressAndContactIfNewForPickUp, startTimeForDropOff: $startTimeForDropOff, endTimeForDropOff: $endTimeForDropOff, genericTypeOfAddressForDropOff: $genericTypeOfAddressForDropOff, addressIdIfExistingForDropOff: $addressIdIfExistingForDropOff, addressAndContactIfNewForDropOff: $addressAndContactIfNewForDropOff, orderIds: $orderIds, driverId: $driverId)';
  }
}

@JsonSerializable(explicitToJson: true)
class AddressWithOtherContactDetails {
  final TypeOfContactForAddress typeOfContactForAddress;
  final String addressLineOne;
  final String? addressLineTwo;
  final String? addressLineThree;
  final String? postalCode;
  final String? city;
  final String? state;
  final String? country;
  final String? countryCode;
  final AddressType? addressType;
  final String? longitute;
  final String? latitude;
  final SpecificTypeOfLocation specificTypeOfLocation;
  final ContactDetail otherContactDetail;

  AddressWithOtherContactDetails({
    required this.typeOfContactForAddress,
    required this.addressLineOne,
    this.addressLineTwo,
    this.addressLineThree,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.addressType,
    this.longitute,
    this.latitude,
    required this.specificTypeOfLocation,
    required this.otherContactDetail,
  });

  factory AddressWithOtherContactDetails.fromJson(Map<String, dynamic> json) =>
      _$AddressWithOtherContactDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AddressWithOtherContactDetailsToJson(this);
}
