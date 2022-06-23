import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/address.model.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
part 'location.model.g.dart';

@JsonSerializable()
class LocationList {
  late final List<Location>? items;
  final Meta? meta;

  LocationList({this.items, this.meta});

  factory LocationList.fromJson(Map<String, dynamic> json) =>
      _$LocationListFromJson(json);

  Map<String, dynamic> toJson() => _$LocationListToJson(this);
}

@JsonSerializable()
class Location {
  Location({
    this.id,
    this.name,
    this.type,
    this.size,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  WarehouseType? type;
  String? size;
  Address? address;
  String? createdAt;
  String? updatedAt;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
