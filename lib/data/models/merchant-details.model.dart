import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/models/address.model.dart';

part 'merchant-details.model.g.dart';

@JsonSerializable(explicitToJson: true)
class MerchantDetails {
  final String? id;
  final String companyName;
  final Address? address;
  final String contactName;
  final String contactEmail;
  final String phoneNumber;
  final String? phoneNumberCountryCode;
  final String? trackingPhoneNumber;
  final String? trackingEmail;
  final String? vat;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  MerchantDetails({
    this.id,
    required this.companyName,
    this.address,
    required this.contactName,
    required this.contactEmail,
    required this.phoneNumber,
    this.phoneNumberCountryCode,
    this.vat,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.trackingEmail,
    this.trackingPhoneNumber,
  });

  factory MerchantDetails.fromJson(Map<String, dynamic> json) =>
      _$MerchantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantDetailsToJson(this);

  @override
  String toString() {
    return 'Merchant(id: $id, companyName: $companyName)';
  }
}
