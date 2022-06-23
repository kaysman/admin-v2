import 'package:json_annotation/json_annotation.dart';
part 'approve-pickup-request.model.g.dart';

@JsonSerializable()
class ApproveRequestModel {
  ApproveRequestModel({
    this.requestId,
    this.driverId,
    this.pickupTimeWindowStart,
    this.pickupTimeWindowEnd,
  });

  String? requestId;
  String? driverId;
  String? pickupTimeWindowStart;
  String? pickupTimeWindowEnd;

  factory ApproveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ApproveRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRequestModelToJson(this);
}
