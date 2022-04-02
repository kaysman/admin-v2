class FlowStepEntity {
  final String? workflowStepIds;
  final String? id;
  final int? sequence;
  final String? workflowStepName;

  const FlowStepEntity({
    this.id,
    this.workflowStepIds,
    this.sequence,
    this.workflowStepName,
  });

  factory FlowStepEntity.fromJson(Map<String, dynamic> json) => FlowStepEntity(
      id: json["id"],
      workflowStepIds: json['workflowStepIds'],
      sequence: json['sequence'],
      workflowStepName: json['workflowStepName']);

  Map<String, dynamic> toJson() => {
        "id": this.id,
        "workflowStepIds": this.workflowStepIds,
        "sequence": this.sequence,
        "workflowStepName": this.workflowStepName,
      };

  @override
  String toString() => "Workflow Step: $workflowStepIds";
}
