import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
part 'location-request.model.g.dart';

@JsonSerializable()
class LocationRequest {
  LocationRequest({
    this.id,
    this.size,
    this.name,
    this.type,
    this.address,
  });

  String? id;
  String? type;
  String? name;
  String? size;
  Address? address;
  factory LocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRequestToJson(this);
}
