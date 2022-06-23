// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowEntity _$WorkflowEntityFromJson(Map<String, dynamic> json) =>
    WorkflowEntity(
      name: json['name'] as String?,
      description: json['description'] as String?,
      workFlowIds: (json['workFlowIds'] as List<dynamic>?)
              ?.map((e) => StandardStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      serviceLevel: json['serviceLevel'] as String?,
      serviceType: json['serviceType'] as String?,
      tenant: json['tenant'] == null
          ? null
          : Tenant.fromJson(json['tenant'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String?,
      workflowAndWorkflowStep:
          (json['workflowAndWorkflowStep'] as List<dynamic>?)
              ?.map((e) => FlowStepEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$WorkflowEntityToJson(WorkflowEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'workFlowIds': instance.workFlowIds?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'serviceType': instance.serviceType,
      'serviceLevel': instance.serviceLevel,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'tenant': instance.tenant?.toJson(),
      'workflowAndWorkflowStep':
          instance.workflowAndWorkflowStep?.map((e) => e.toJson()).toList(),
    };
