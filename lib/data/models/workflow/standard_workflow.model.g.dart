// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standard_workflow.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkflowStandard _$WorkflowStandardFromJson(Map<String, dynamic> json) =>
    WorkflowStandard(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            $enumDecode(_$StandardWorkflowTypeEnumMap, k), e as String),
      ),
    );

Map<String, dynamic> _$WorkflowStandardToJson(WorkflowStandard instance) =>
    <String, dynamic>{
      'data': instance.data
          ?.map((k, e) => MapEntry(_$StandardWorkflowTypeEnumMap[k], e)),
    };

const _$StandardWorkflowTypeEnumMap = {
  StandardWorkflowType.Pick_up_and_drop_off_directly:
      'Pick_up_and_drop_off_directly',
  StandardWorkflowType.To_warehouse_before_delivery:
      'To_warehouse_before_delivery',
  StandardWorkflowType.To_warehouse_and_dispatch_point_before_delivery:
      'To_warehouse_and_dispatch_point_before_delivery',
  StandardWorkflowType.Custom: 'Custom',
};
