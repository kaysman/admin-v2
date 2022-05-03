// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      id: json['id'] as String?,
      code: $enumDecodeNullable(_$PermissionTypeEnumMap, json['code']),
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': _$PermissionTypeEnumMap[instance.code],
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$PermissionTypeEnumMap = {
  PermissionType.CREATE_ADDRESS: 'create-address',
  PermissionType.READ_ADDRESS: 'read-address',
  PermissionType.UPDATE_ADDRESS: 'update-address',
  PermissionType.DELETE_ADDRESS: 'delete-address',
  PermissionType.CREATE_AUDIT_LOG: 'create-audit-log',
  PermissionType.READ_AUDIT_LOG: 'read-audit-log',
  PermissionType.LOG_IN: 'log-in',
  PermissionType.CHANGE_PASSWORD: 'change-password',
  PermissionType.CREATE_DRIVER: 'create-driver',
  PermissionType.READ_DRIVER: 'read-driver',
  PermissionType.UPDATE_DRIVER: 'update-driver',
  PermissionType.DELETE_DRIVER: 'delete-driver',
  PermissionType.CREATE_MERCHANT: 'create-merchant',
  PermissionType.READ_MERCHANT: 'read-merchant',
  PermissionType.UPDATE_MERCHANT: 'update-merchant',
  PermissionType.DELETE_MERCHANT: 'delete-merchant',
  PermissionType.CREATE_MODULE: 'create-module',
  PermissionType.READ_MODULE: 'read-module',
  PermissionType.UPDATE_MODULE: 'update-module',
  PermissionType.DELETE_MODULE: 'delete-module',
  PermissionType.CREATE_ORDER: 'create-order',
  PermissionType.READ_ORDER: 'read-order',
  PermissionType.UPDATE_ORDER: 'update-order',
  PermissionType.DELETE_ORDER: 'delete-order',
  PermissionType.CREATE_ORDER_TIMELINE: 'create-order-timeline',
  PermissionType.READ_ORDER_TIMELINE: 'read-order-timeline',
  PermissionType.CREATE_ORDER_UPLOAD: 'create-order-upload',
  PermissionType.READ_ORDER_UPLOAD: 'read-order-upload',
  PermissionType.CREATE_PERMISSION: 'create-permission',
  PermissionType.READ_PERMISSION: 'read-permission',
  PermissionType.CREATE_PROOF_OF_DELIVERY: 'create-proof-of-delivery',
  PermissionType.CREATE_REQUEST: 'create-request',
  PermissionType.READ_REQUEST: 'read-request',
  PermissionType.UPDATE_REQUEST: 'update-request',
  PermissionType.DELETE_REQUEST: 'delete-request',
  PermissionType.CREATE_ROLE: 'create-role',
  PermissionType.READ_ROLE: 'read-role',
  PermissionType.UPDATE_ROLE: 'update-role',
  PermissionType.DELETE_ROLE: 'delete-role',
  PermissionType.CREATE_TASK: 'create-task',
  PermissionType.READ_TASK: 'read-task',
  PermissionType.UPDATE_TASK: 'update-task',
  PermissionType.DELETE_TASK: 'delete-task',
  PermissionType.CREATE_TEAM: 'create-team',
  PermissionType.READ_TEAM: 'read-team',
  PermissionType.UPDATE_TEAM: 'update-team',
  PermissionType.DELETE_TEAM: 'delete-team',
  PermissionType.CREATE_TENANT: 'create-tenant',
  PermissionType.READ_TENANT: 'read-tenant',
  PermissionType.UPDATE_TENANT: 'update-tenant',
  PermissionType.DELETE_TENANT: 'delete-tenant',
  PermissionType.CREATE_UPLOAD: 'create-upload',
  PermissionType.CREATE_USER: 'create-user',
  PermissionType.READ_USER: 'read-user',
  PermissionType.UPDATE_USER: 'update-user',
  PermissionType.DELETE_USER: 'delete-user',
  PermissionType.CREATE_WAREHOUSE: 'create-warehouse',
  PermissionType.READ_WAREHOUSE: 'read-warehouse',
  PermissionType.UPDATE_WAREHOUSE: 'update-warehouse',
  PermissionType.DELETE_WAREHOUSE: 'delete-warehouse',
  PermissionType.CREATE_WORKFLOW: 'create-workflow',
  PermissionType.READ_WORKFLOW: 'read-workflow',
  PermissionType.UPDATE_WORKFLOW: 'update-workflow',
  PermissionType.DELETE_WORKFLOW: 'delete-workflow',
  PermissionType.CREATE_WORKFLOW_WAREHOUSE: 'create-workflow-warehouse',
  PermissionType.READ_WORKFLOW_WAREHOUSE: 'read-workflow-warehouse',
  PermissionType.CREATE_WORKFLOW_STEP: 'create-workflow-step',
  PermissionType.READ_WORKFLOW_STEP: 'read-workflow-step',
  PermissionType.UPDATE_WORKFLOW_STEP: 'update-workflow-step',
  PermissionType.DELETE_WORKFLOW_STEP: 'delete-workflow-step',
  PermissionType.ONLY_LOAD_AND_GO_TECH: 'only-load-and-go-tech',
  PermissionType.CREATE_TASK_SEQUENCING: 'create-task-sequencing',
  PermissionType.READ_TASK_SEQUENCING: 'read-task-sequencing',
  PermissionType.UPDATE_TASK_SEQUENCING: 'update-task-sequencing',
  PermissionType.DELETE_TASK_SEQUENCING: 'delete-task-sequencing',
  PermissionType.READ_VEHICLE_DETAIL: 'read-vehicle-detail',
  PermissionType.CREATE_WORKFLOW_AND_WORKFLOW_STEP:
      'create-workflow-and-workflow-step',
  PermissionType.READ_WORKFLOW_AND_WORKFLOW_STEP:
      'read-workflow-and-workflow-step',
  PermissionType.UPDATE_WORKFLOW_AND_WORKFLOW_STEP:
      'update-workflow-and-workflow-step',
  PermissionType.DELETE_WORKFLOW_AND_WORKFLOW_STEP:
      'delete-workflow-and-workflow-step',
};

PermissionsByModule _$PermissionsByModuleFromJson(Map<String, dynamic> json) =>
    PermissionsByModule(
      data: (json['data'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => Permission.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$PermissionsByModuleToJson(
        PermissionsByModule instance) =>
    <String, dynamic>{
      'data': instance.data
          ?.map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
    };
