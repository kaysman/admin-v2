import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/models/address.model.dart';

part 'update-tenant.model.g.dart';

@JsonSerializable()
class UpdateTenantRequest {
  final String? id;
  final String? name;
  final String? contactName;
  final String? contactEmail;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;
  final String? vat;
  final Address? address;

  UpdateTenantRequest({
    this.id,
    this.name,
    this.contactName,
    this.contactEmail,
    this.phoneNumberCountryCode,
    this.phoneNumber,
    this.vat,
    this.address,
  });

  factory UpdateTenantRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTenantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTenantRequestToJson(this);
}
