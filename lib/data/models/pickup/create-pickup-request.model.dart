import 'package:json_annotation/json_annotation.dart';
part 'create-pickup-request.model.g.dart';

@JsonSerializable()
class CreatePickupRequest {
  CreatePickupRequest({
    this.type,
    this.numberOfItems,
    this.weight,
    this.pickupTimeWindowStart,
    this.pickupTimeWindowEnd,
  });

  String? type;
  int? numberOfItems;
  int? weight;
  String? pickupTimeWindowStart;
  String? pickupTimeWindowEnd;

  factory CreatePickupRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePickupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePickupRequestToJson(this);
}
