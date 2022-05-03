import 'package:json_annotation/json_annotation.dart';
part 'create-team-request.model.g.dart';

@JsonSerializable()
class CreateTeamRequest {
  CreateTeamRequest({
    this.name,
    this.description,
    this.driverIds,
  });

  String? name;
  String? description;
  List<String>? driverIds;

  factory CreateTeamRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTeamRequestToJson(this);
}

@JsonSerializable()
class UpdateTeamRequest {
  UpdateTeamRequest({
    this.id,
    this.name,
    this.description,
    this.driverIds,
  });

  int? id;
  String? name;
  String? description;
  List<String>? driverIds;

  factory UpdateTeamRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTeamRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTeamRequestToJson(this);
}
