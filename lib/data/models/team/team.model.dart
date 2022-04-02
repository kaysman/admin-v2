import 'package:json_annotation/json_annotation.dart';
import 'package:lng_adminapp/data/models/meta.model.dart';
part 'team.model.g.dart';

@JsonSerializable()
class TeamList {
  late final List<Team>? items;
  final Meta? meta;

  TeamList({this.items, this.meta});

  factory TeamList.fromJson(Map<String, dynamic> json) =>
      _$TeamListFromJson(json);

  Map<String, dynamic> toJson() => _$TeamListToJson(this);
}

@JsonSerializable()
class Team {
  Team({
    this.id,
    this.name,
    this.description,
    this.warehouse,
    this.drivers,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  dynamic warehouse;
  List<dynamic>? drivers;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
