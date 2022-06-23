import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';

import 'package:lng_adminapp/data/models/driver-details.model.dart';
import 'package:lng_adminapp/data/models/merchant-details.model.dart';
part 'create-user-within-system.model.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateUserWithinSystem {
  final String? id;
  final SpecificTypeOfUser typeOfUserCreated;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String password;
  final String? phoneNumberCountryCode;
  final String phoneNumber;
  final String? photoUrl;
  final MerchantDetails? merchantDetails;
  final DriverDetails? driverDetails;
  final String roleId;

  CreateUserWithinSystem({
    this.id,
    required this.typeOfUserCreated,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.password,
    this.phoneNumberCountryCode,
    required this.phoneNumber,
    this.photoUrl,
    this.merchantDetails,
    this.driverDetails,
    required this.roleId,
  });

  factory CreateUserWithinSystem.fromJson(Map<String, dynamic> json) =>
      _$CreateUserWithinSystemFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserWithinSystemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateUserWithinSystem {
  final String id;
  final String firstName;
  final String lastName;
  final String? phoneNumberCountryCode;
  final String phoneNumber;
  final String? photoUrl;
  final MerchantDetails? merchantDetails;
  final DriverDetails? driverDetails;

  UpdateUserWithinSystem({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phoneNumberCountryCode,
    required this.phoneNumber,
    this.photoUrl,
    this.merchantDetails,
    this.driverDetails,
  });

  factory UpdateUserWithinSystem.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserWithinSystemFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserWithinSystemToJson(this);
}
