import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/team/create-team-request.model.dart';
import 'package:lng_adminapp/data/models/team/team.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class TeamService {
  static final selectedTeam = ValueNotifier<Team?>(null);

  static Future<ApiResponse> createTeam(
      CreateTeamRequest data, bool isUpdating) async {
    var uri = Uri.https(apiUrl, '/api/v1/teams/create');
    var response;
    try {
      if (isUpdating) {
        response = await ApiClient.instance.patch(
          uri,
          headers: await headers,
          data: json.encode(data.toJson()),
        );
      } else {
        response = await ApiClient.instance.post(
          uri,
          headers: await headers,
          data: jsonEncode(data.toJson()),
        );
      }
    } catch (_) {
      throw _;
    }

    return response;
  }

  static Future<TeamList> getTeams(Map<String, String> params) async {
    var uri = Uri.https(apiUrl, '/api/v1/teams', params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = TeamList.fromJson(res.data);

      return data;
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching users',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<ApiResponse> deleteTeam(String id) async {
    var uri = Uri.https(apiUrl, '/api/v1/teams/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: await headers);
      return res;
    } catch (_) {
      throw _;
    }
  }
}
