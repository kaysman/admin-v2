import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  Driver({required this.id, this.name, this.phone, this.address, this.teams});

  final String id;
  final String? name;
  final String? phone;
  final String? address;
  final List<String>? teams;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Driver && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  Driver copyWith(
      {String? id,
      String? name,
      String? phone,
      String? address,
      List<String>? teams}) {
    return Driver(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      teams: teams ?? this.teams,
    );
  }
}
