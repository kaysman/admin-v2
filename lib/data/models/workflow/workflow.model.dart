import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/merchant.model.dart';
import 'package:lng_adminapp/data/models/tenant.model.dart';
import 'flow_step.model.dart';
part 'workflow.model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkflowEntity {
  final String? name;
  final String? description;
  final List<StandardStep>? workFlowIds;

  final String? id;
  final String? serviceType;
  final String? serviceLevel;
  final String? createdAt;
  final String? updatedAt;
  final Tenant? tenant;
  final List<FlowStepEntity>? workflowAndWorkflowStep;

  WorkflowEntity({
    this.name,
    this.description,
    this.workFlowIds = const [],
    this.id,
    this.createdAt,
    this.serviceLevel,
    this.serviceType,
    this.tenant,
    this.updatedAt,
    this.workflowAndWorkflowStep,
  });

  factory WorkflowEntity.fromJson(Map<String, dynamic> json) =>
      _$WorkflowEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WorkflowEntityToJson(this);

  WorkflowEntity copyWith({
    String? name,
    String? description,
    List<StandardStep>? workFlowIds,
    String? id,
    String? serviceType,
    String? serviceLevel,
    String? createdAt,
    String? updatedAt,
    Tenant? tenant,
    Merchant? merchant,
    List<FlowStepEntity>? workflowAndWorkflowStep,
  }) {
    return WorkflowEntity(
      name: name ?? this.name,
      description: description ?? this.description,
      workFlowIds: workFlowIds ?? this.workFlowIds,
      id: id ?? this.id,
      serviceType: serviceType ?? this.serviceType,
      serviceLevel: serviceLevel ?? this.serviceLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tenant: tenant ?? this.tenant,
      workflowAndWorkflowStep:
          workflowAndWorkflowStep ?? this.workflowAndWorkflowStep,
    );
  }

  @override
  String toString() => "Workflow: $id";
}
