import 'package:json_annotation/json_annotation.dart';

import '../../enums/status.enum.dart';

part 'permission.model.g.dart';

@JsonSerializable()
class Permission {
  Permission({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final PermissionType? code;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Permission && other.id == id && other.code == code;
  }

  @override
  int get hashCode {
    return id.hashCode ^ code.hashCode;
  }

  @override
  String toString() {
    return 'Permission(code: $code)';
  }
}

@JsonSerializable(explicitToJson: true)
class PermissionsByModule {
  final Map<String, List<Permission>>? data;

  PermissionsByModule({this.data});

  factory PermissionsByModule.fromJson(Map<String, dynamic> json) =>
      PermissionsByModule(
        data: json.map(
          (k, e) => MapEntry(
              k,
              (e as List<dynamic>)
                  .map((e) => Permission.fromJson(e as Map<String, dynamic>))
                  .toList()),
        ),
      );
}
