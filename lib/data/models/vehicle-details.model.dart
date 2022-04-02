import 'package:json_annotation/json_annotation.dart';
part 'vehicle-details.model.g.dart';

@JsonSerializable()
class VehicleDetail {
  VehicleDetail({
    this.id,
    this.color,
    this.year,
    this.model,
    this.licensePlate,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? color;
  String? year;
  String? model;
  String? licensePlate;
  String? createdAt;
  String? updatedAt;

  factory VehicleDetail.fromJson(Map<String, dynamic> json) =>
      _$VehicleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleDetailToJson(this);
}
