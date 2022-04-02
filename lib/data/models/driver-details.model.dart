import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/vehicle-details.model.dart';
part 'driver-details.model.g.dart';

@JsonSerializable()
class DriverDetails {
  DriverDetails({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.vehicleType,
    this.address,
    this.vehicleDetail,
    this.description,
  });

  String? id;
  String? vehicleType;
  Address? address;
  VehicleDetail? vehicleDetail;
  String? description;
  String? createdAt;
  String? updatedAt;

  factory DriverDetails.fromJson(Map<String, dynamic> json) =>
      _$DriverDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDetailsToJson(this);
}
