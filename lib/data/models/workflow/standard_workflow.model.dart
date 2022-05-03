import 'package:json_annotation/json_annotation.dart';
import '../../enums/status.enum.dart';

class WorkflowStandard {
  final List<StandardWorkflowType>? data;
  const WorkflowStandard({this.data});

  factory WorkflowStandard.fromJson(List<dynamic>? json) => WorkflowStandard(
      data: json
          ?.map((e) => $enumDecode(_$StandardWorkflowTypeEnumMap, e))
          .toList());

  @override
  String toString() => "$data";
}

const _$StandardWorkflowTypeEnumMap = {
  StandardWorkflowType.Pick_up_and_drop_off_directly:
      'Pick_up_and_drop_off_directly',
  StandardWorkflowType.To_warehouse_before_delivery:
      'To_warehouse_before_delivery',
  StandardWorkflowType.To_warehouse_and_dispatch_point_before_delivery:
      'To_warehouse_and_dispatch_point_before_delivery',
  StandardWorkflowType.Custom: 'Custom',
};
