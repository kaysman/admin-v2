import 'package:json_annotation/json_annotation.dart';
part 'create-team-request.model.g.dart';

@JsonSerializable()
class CreateTeamRequest {
  CreateTeamRequest({
    this.id,
    this.name,
    this.description,
    this.driverIds,
  });
  String? id;
  String? name;
  String? description;
  List<String>? driverIds;

  factory CreateTeamRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTeamRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTeamRequestToJson(this);
}
