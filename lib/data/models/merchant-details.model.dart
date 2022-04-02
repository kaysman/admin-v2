import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
part 'merchant-details.model.g.dart';

@JsonSerializable()
class MerchantDetails {
  final String? id;
  final String? companyName;
  final String? contactName;
  final String? contactEmail;
  final String? phoneNumber;
  final Address? address;
  final String? vat;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  MerchantDetails({
    this.id,
    this.companyName,
    this.contactEmail,
    this.contactName,
    this.createdAt,
    this.address,
    this.phoneNumber,
    this.status,
    this.updatedAt,
    this.vat,
  });

  factory MerchantDetails.fromJson(Map<String, dynamic> json) =>
      _$MerchantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantDetailsToJson(this);

  @override
  String toString() {
    return 'Merchant(id: $id, companyName: $companyName)';
  }
}
