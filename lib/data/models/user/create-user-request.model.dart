import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/driver-details.model.dart';
import 'package:lng_adminapp/data/models/merchant-details.model.dart';
part 'create-user-request.model.g.dart';

@JsonSerializable()
class CreateUserRequest {
  CreateUserRequest({
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.password,
    this.countryCode,
    this.phoneNumber,
    this.photoUrl,
    this.roleId,
    this.status,
    this.merchantDetails,
    this.driverDetails,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? password;
  String? countryCode;
  String? phoneNumber;
  String? photoUrl;
  String? roleId;
  String? status;
  String? createdAt;
  String? updatedAt;
  MerchantDetails? merchantDetails;
  DriverDetails? driverDetails;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);
}
