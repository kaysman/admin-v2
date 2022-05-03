// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flow_step.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlowStepEntity _$FlowStepEntityFromJson(Map<String, dynamic> json) =>
    FlowStepEntity(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      sequence: json['sequence'] as int?,
      workflowStep: json['workflowStep'] == null
          ? null
          : WorkflowStep.fromJson(json['workflowStep'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlowStepEntityToJson(FlowStepEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'sequence': instance.sequence,
      'workflowStep': instance.workflowStep?.toJson(),
    };

WorkflowStep _$WorkflowStepFromJson(Map<String, dynamic> json) => WorkflowStep(
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      linkedToWarehouse: json['linkedToWarehouse'] as bool?,
    );

Map<String, dynamic> _$WorkflowStepToJson(WorkflowStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'type': instance.type,
      'linkedToWarehouse': instance.linkedToWarehouse,
    };

StandardStep _$StandardStepFromJson(Map<String, dynamic> json) => StandardStep(
      workflowStepIds: json['workflowStepIds'] as String?,
      sequence: json['sequence'] as int?,
      workflowStepName: json['workflowStepName'] as String?,
    );

Map<String, dynamic> _$StandardStepToJson(StandardStep instance) =>
    <String, dynamic>{
      'workflowStepIds': instance.workflowStepIds,
      'sequence': instance.sequence,
      'workflowStepName': instance.workflowStepName,
    };
