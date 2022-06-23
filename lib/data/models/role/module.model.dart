import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/role/permission.model.dart';

part 'module.model.g.dart';

@JsonSerializable()
class Module {
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<Permission>? permissions;

  Module({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.permissions,
  });

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
