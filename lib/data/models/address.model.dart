import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
part 'address.model.g.dart';

@JsonSerializable()
class Address {
  final String? id;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? addressLineThree;
  final String? postalCode;
  final String? city;
  final String? state;
  final String? country;
  final String? countryCode;
  final AddressType? addressType;
  final String? longitude;
  final String? latitude;
  final String? createdAt;
  final String? updatedAt;

  Address({
    this.id,
    this.addressLineOne,
    this.addressLineTwo,
    this.addressLineThree,
    this.city,
    this.country,
    this.countryCode,
    this.createdAt,
    this.postalCode,
    this.state,
    this.updatedAt,
    this.addressType,
    this.longitude,
    this.latitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
