// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-team-request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTeamRequest _$CreateTeamRequestFromJson(Map<String, dynamic> json) =>
    CreateTeamRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      driverIds: (json['driverIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateTeamRequestToJson(CreateTeamRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'driverIds': instance.driverIds,
    };

UpdateTeamRequest _$UpdateTeamRequestFromJson(Map<String, dynamic> json) =>
    UpdateTeamRequest(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      driverIds: (json['driverIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateTeamRequestToJson(UpdateTeamRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'driverIds': instance.driverIds,
    };
