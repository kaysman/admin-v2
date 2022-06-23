import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';

import '../contact-detail.model.dart';
part 'location-request.model.g.dart';

@JsonSerializable()
class LocationRequest {
  LocationRequest({
    this.id,
    required this.size,
    required this.name,
    required this.type,
    required this.address,
    required this.contactDetails,
  });

  final String? id;
  final String name;
  final String size;
  final WarehouseType type;
  final Address address;
  final ContactDetail contactDetails;

  factory LocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LocationRequestToJson(this);
}
