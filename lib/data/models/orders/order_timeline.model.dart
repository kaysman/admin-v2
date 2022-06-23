import 'package:json_annotation/json_annotation.dart';

import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';

part 'order_timeline.model.g.dart';

@JsonSerializable()
class OrderTimeline {
  final String? id;
  final Order? order;
  final String? description;
  final String? status;
  final TypesOfOrderTimelineLogs? typeOfOrderTimelineLog;
  final WorkflowStepType? typeOfWorkflowStep;
  final WorkflowStepIsTaskRelated? taskRelated;
  final bool? viewableByLoadAndGo;
  final bool? viewableByTenant;
  final bool? viewableByMerchant;
  final bool? viewableByDriver;
  final bool? viewableByReceiver;
  final User? createdBy;
  final String? createdAt;
  final String? updatedAt;

  OrderTimeline({
    this.id,
    this.order,
    this.description,
    this.status,
    this.typeOfOrderTimelineLog,
    this.typeOfWorkflowStep,
    this.taskRelated,
    this.viewableByLoadAndGo,
    this.viewableByTenant,
    this.viewableByMerchant,
    this.viewableByDriver,
    this.viewableByReceiver,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderTimeline.fromJson(Map<String, dynamic> json) =>
      _$OrderTimelineFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTimelineToJson(this);
}
