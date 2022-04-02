import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/models/user/create-user-request.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class UserService {
  // static String apiUrl = "lng-test-environment.as.r.appspot.com";
  static final selectedDriver = ValueNotifier<User?>(null);
  static final selectedMerchant = ValueNotifier<User?>(null);

  static Future<ApiResponse> createUser(
      CreateUserRequest data, bool isUpdating) async {
    var uri = Uri.http(apiUrl, '/api/v1/users');

    try {
      var response;

      if (isUpdating) {
        response = await ApiClient.instance.patch(
          uri,
          headers: await headers,
          data: jsonEncode(data.toJson()),
        );
      } else {
        response = await ApiClient.instance.post(
          uri,
          headers: await headers,
          data: jsonEncode(data.toJson()),
        );
      }

      return response;
    } catch (_) {
      // TODO: Display modal of the error
      throw _;
    }
  }

  static Future<UserList> getUsers(Map<String, String> params) async {
    var uri = Uri.http(apiUrl, "/api/v1/users", params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = UserList.fromJson(res.data);
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

  static Future<ApiResponse> deleteUser(String id) async {
    var uri = Uri.http(apiUrl, '/api/v1/users/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: await headers);
      return res;
    } catch (_) {
      throw _;
    }
  }
}
