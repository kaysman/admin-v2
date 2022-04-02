import 'package:json_annotation/json_annotation.dart';
part 'order_timeline.model.g.dart';

@JsonSerializable()
class OrderTimeline {
  OrderTimeline({
    this.id,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory OrderTimeline.fromJson(Map<String, dynamic> json) =>
      _$OrderTimelineFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTimelineToJson(this);
}
