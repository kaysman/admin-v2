import 'package:json_annotation/json_annotation.dart';

part 'flow_step.model.g.dart';

@JsonSerializable(explicitToJson: true)
class FlowStepEntity {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? sequence;
  final WorkflowStep? workflowStep;

  const FlowStepEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sequence,
    this.workflowStep,
  });

  factory FlowStepEntity.fromJson(Map<String, dynamic> json) =>
      _$FlowStepEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FlowStepEntityToJson(this);

  @override
  String toString() => "Workflow Step: $id";
}

@JsonSerializable()
class WorkflowStep {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? type;
  final String? linkedToWarehouse;

  WorkflowStep({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.type,
    this.linkedToWarehouse,
  });

  factory WorkflowStep.fromJson(Map<String, dynamic> json) =>
      _$WorkflowStepFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowStepToJson(this);
}

@JsonSerializable()
class StandardStep {
  final String? workflowStepIds;
  final int? sequence;
  final String? workflowStepName;
  final String? taggedWarehouseId;

  StandardStep({
    this.workflowStepIds,
    this.sequence,
    this.workflowStepName,
    this.taggedWarehouseId,
  });

  factory StandardStep.fromJson(Map<String, dynamic> json) =>
      _$StandardStepFromJson(json);

  Map<String, dynamic> toJson() => _$StandardStepToJson(this);
}
