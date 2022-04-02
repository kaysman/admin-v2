import 'package:json_annotation/json_annotation.dart';
import '../../enums/status.enum.dart';
part 'standard_workflow.model.g.dart';

@JsonSerializable()
class WorkflowStandard {
  final Map<StandardWorkflowType, String>? data;
  const WorkflowStandard({this.data});

  factory WorkflowStandard.fromJson(Map<String, dynamic> json) =>
      WorkflowStandard(
        data: (json as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              $enumDecode(_$StandardWorkflowTypeEnumMap, k), e as String),
        ),
      );

  Map<String, dynamic> toJson() => _$WorkflowStandardToJson(this);

  @override
  String toString() => "$data";
}
