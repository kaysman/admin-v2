import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
import 'package:lng_adminapp/data/models/role/permission.model.dart';
import 'package:lng_adminapp/data/models/tenant.model.dart';
import 'package:lng_adminapp/data/models/user.model.dart';

import '../../enums/status.enum.dart';
part 'role.model.g.dart';

@JsonSerializable()
class RoleList {
  final List<Role>? items;
  final Meta? meta;

  RoleList({this.items, this.meta});

  factory RoleList.fromJson(Map<String, dynamic> json) =>
      _$RoleListFromJson(json);

  Map<String, dynamic> toJson() => _$RoleListToJson(this);
}

@JsonSerializable()
class Role {
  final String? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final List<Permission>? permissions;
  final Tenant? tenant;
  final User? createdBy;

  Role({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.tenant,
    this.permissions,
    this.createdBy,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
