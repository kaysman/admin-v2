// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_timeline.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTimeline _$OrderTimelineFromJson(Map<String, dynamic> json) =>
    OrderTimeline(
      id: json['id'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      description: json['description'] as String?,
      status: json['status'] as String?,
      typeOfOrderTimelineLog: $enumDecodeNullable(
          _$TypesOfOrderTimelineLogsEnumMap, json['typeOfOrderTimelineLog']),
      typeOfWorkflowStep: $enumDecodeNullable(
          _$WorkflowStepTypeEnumMap, json['typeOfWorkflowStep']),
      taskRelated: $enumDecodeNullable(
          _$WorkflowStepIsTaskRelatedEnumMap, json['taskRelated']),
      viewableByLoadAndGo: json['viewableByLoadAndGo'] as bool?,
      viewableByTenant: json['viewableByTenant'] as bool?,
      viewableByMerchant: json['viewableByMerchant'] as bool?,
      viewableByDriver: json['viewableByDriver'] as bool?,
      viewableByReceiver: json['viewableByReceiver'] as bool?,
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrderTimelineToJson(OrderTimeline instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order': instance.order,
      'description': instance.description,
      'status': instance.status,
      'typeOfOrderTimelineLog':
          _$TypesOfOrderTimelineLogsEnumMap[instance.typeOfOrderTimelineLog],
      'typeOfWorkflowStep':
          _$WorkflowStepTypeEnumMap[instance.typeOfWorkflowStep],
      'taskRelated': _$WorkflowStepIsTaskRelatedEnumMap[instance.taskRelated],
      'viewableByLoadAndGo': instance.viewableByLoadAndGo,
      'viewableByTenant': instance.viewableByTenant,
      'viewableByMerchant': instance.viewableByMerchant,
      'viewableByDriver': instance.viewableByDriver,
      'viewableByReceiver': instance.viewableByReceiver,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$TypesOfOrderTimelineLogsEnumMap = {
  TypesOfOrderTimelineLogs.REGULAR_LOGGING: 'REGULAR_LOGGING',
  TypesOfOrderTimelineLogs.ORDER_CREATED: 'ORDER_CREATED',
  TypesOfOrderTimelineLogs.ORDER_SCANNED: 'ORDER_SCANNED',
  TypesOfOrderTimelineLogs.ORDER_TAGGED_TO_TASK: 'ORDER_TAGGED_TO_TASK',
  TypesOfOrderTimelineLogs.SHIPPING_LABEL_PRINTED: 'SHIPPING_LABEL_PRINTED',
  TypesOfOrderTimelineLogs.READY_FOR_PICK_UP: 'READY_FOR_PICK_UP',
  TypesOfOrderTimelineLogs.PICK_UP_CONFIRMED: 'PICK_UP_CONFIRMED',
  TypesOfOrderTimelineLogs
          .TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  TypesOfOrderTimelineLogs
          .TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  TypesOfOrderTimelineLogs
          .TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  TypesOfOrderTimelineLogs.IN_WAREHOUSE_FOR_SORTING: 'IN_WAREHOUSE_FOR_SORTING',
  TypesOfOrderTimelineLogs
          .TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  TypesOfOrderTimelineLogs
          .TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  TypesOfOrderTimelineLogs
          .TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  TypesOfOrderTimelineLogs
          .TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_FOR_DELIVERY:
      'TASK_CREATION_ASSIGNMENT_OF_DRIVER_FOR_ON_VEHICLE_FOR_DELIVERY',
  TypesOfOrderTimelineLogs
          .TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_FOR_DELIVERY:
      'TASK_IN_PROGRESS_PICKED_UP_FOR_ON_VEHICLE_FOR_DELIVERY',
  TypesOfOrderTimelineLogs
          .TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_FOR_DELIVERY:
      'TASK_COMPLETION_DROPPED_OFF_FOR_ON_VEHICLE_FOR_DELIVERY',
  TypesOfOrderTimelineLogs.ORDER_COMPLETED: 'ORDER_COMPLETED',
  TypesOfOrderTimelineLogs.TASK_CREATION_CUSTOM_TASK_RELATED:
      'TASK_CREATION_CUSTOM_TASK_RELATED',
  TypesOfOrderTimelineLogs
          .TASK_IN_PROGRESS_PICKED_UP_TASK_CREATION_CUSTOM_TASK_RELATED:
      'TASK_IN_PROGRESS_PICKED_UP_TASK_CREATION_CUSTOM_TASK_RELATED',
  TypesOfOrderTimelineLogs
          .TASK_COMPLETION_DROPPED_OFF_TASK_CREATION_CUSTOM_TASK_RELATED:
      'TASK_COMPLETION_DROPPED_OFF_TASK_CREATION_CUSTOM_TASK_RELATED',
  TypesOfOrderTimelineLogs.FAILED_PICK_UP: 'FAILED_PICK_UP',
  TypesOfOrderTimelineLogs.DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT',
  TypesOfOrderTimelineLogs
          .DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  TypesOfOrderTimelineLogs
          .DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  TypesOfOrderTimelineLogs
          .DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  TypesOfOrderTimelineLogs
          .DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  TypesOfOrderTimelineLogs.DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER',
  TypesOfOrderTimelineLogs.DELIVERY_ENDED_RETURNED_TO_SENDER:
      'DELIVERY_ENDED_RETURNED_TO_SENDER',
};

const _$WorkflowStepTypeEnumMap = {
  WorkflowStepType.ORDER_CREATED: 'ORDER_CREATED',
  WorkflowStepType.SHIPPING_LABEL_PRINTED: 'SHIPPING_LABEL_PRINTED',
  WorkflowStepType.READY_FOR_PICK_UP: 'READY_FOR_PICK_UP',
  WorkflowStepType.PICK_UP_CONFIRMED: 'PICK_UP_CONFIRMED',
  WorkflowStepType.ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING:
      'ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING',
  WorkflowStepType.IN_WAREHOUSE_FOR_SORTING: 'IN_WAREHOUSE_FOR_SORTING',
  WorkflowStepType.ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH:
      'ON_VEHICLE_TO_DISPATCH_POINT_FOR_DELIVERY_DISPATCH',
  WorkflowStepType.ON_VEHICLE_FOR_DELIVERY: 'ON_VEHICLE_FOR_DELIVERY',
  WorkflowStepType.ORDER_COMPLETED: 'ORDER_COMPLETED',
  WorkflowStepType.FAILED_PICK_UP: 'FAILED_PICK_UP',
  WorkflowStepType.DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_FOR_DELIVERY_REATTEMPT',
  WorkflowStepType
          .DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  WorkflowStepType
          .DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  WorkflowStepType
          .DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_DELIVERY_REATTEMPT',
  WorkflowStepType
          .DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER:
      'DELIVERY_FAILED_IN_WAREHOUSE_FOR_SORTING_BEFORE_RETURN_TO_SENDER',
  WorkflowStepType.DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER:
      'DELIVERY_FAILED_ON_VEHICLE_TO_RETURN_TO_SENDER',
  WorkflowStepType.DELIVERY_ENDED_RETURNED_TO_SENDER:
      'DELIVERY_ENDED_RETURNED_TO_SENDER',
  WorkflowStepType.CUSTOM_TASK_RELATED: 'CUSTOM_TASK_RELATED',
  WorkflowStepType.CUSTOM_NOT_TASK_RELATED: 'CUSTOM_NOT_TASK_RELATED',
};

const _$WorkflowStepIsTaskRelatedEnumMap = {
  WorkflowStepIsTaskRelated.TASK_RELATED: 'TASK_RELATED',
  WorkflowStepIsTaskRelated.NOT_TASK_RELATED: 'NOT_TASK_RELATED',
  WorkflowStepIsTaskRelated.NOT_USED_AT_THE_MOMENT: 'NOT_USED_AT_THE_MOMENT',
};
