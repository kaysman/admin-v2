import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';

part 'tenant.model.g.dart';

@JsonSerializable()
class Tenant {
  final String? id;
  final String? name;
  final String? contactName;
  final String? contactEmail;
  final String? phoneNumber;
  final String? vat;
  final Address? address;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Tenant({
    this.id,
    this.name,
    this.contactName,
    this.contactEmail,
    this.phoneNumber,
    this.createdAt,
    this.status,
    this.updatedAt,
    this.vat,
    this.address,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);

  Map<String, dynamic> toJson() => _$TenantToJson(this);

  @override
  String toString() {
    return 'Tenant(id: $id, name: $name)';
  }
}
