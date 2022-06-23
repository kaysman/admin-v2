import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/vehicle-details.model.dart';

import '../enums/status.enum.dart';
part 'driver-details.model.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverDetails {
  DriverDetails({
    this.id,
    required this.vehicleType,
    required this.address,
    required this.vehicleDetail,
    this.description,
  });

  final String? id;
  final VehicleType vehicleType;
  final Address? address;
  final VehicleDetail vehicleDetail;
  final String? description;

  factory DriverDetails.fromJson(Map<String, dynamic> json) =>
      _$DriverDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DriverDetailsToJson(this);
}
