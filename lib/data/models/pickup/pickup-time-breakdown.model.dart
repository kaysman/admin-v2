import 'package:json_annotation/json_annotation.dart';
part 'pickup-time-breakdown.model.g.dart';

@JsonSerializable()
class PickupTimeBreakDown {
  PickupTimeBreakDown({
    this.date,
    this.pickupTime,
    this.closingTime,
  });

  String? date;
  String? pickupTime;
  String? closingTime;

  factory PickupTimeBreakDown.fromJson(Map<String, dynamic> json) =>
      _$PickupTimeBreakDownFromJson(json);

  Map<String, dynamic> toJson() => _$PickupTimeBreakDownToJson(this);
}
