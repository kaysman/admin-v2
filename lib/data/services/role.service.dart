import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/role/create-role.model.dart';
import 'package:lng_adminapp/data/models/role/module.model.dart';
import 'package:lng_adminapp/data/models/role/permission.model.dart';
import 'package:lng_adminapp/data/models/role/role.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/shared.dart';

class RoleAndPermissionsService {
  static final selectedRole = ValueNotifier<Role?>(null);
  static final modules = ValueNotifier<List<Module>?>(null);
  static final selectedRolePermissions = ValueNotifier<List<Permission>?>(null);

  static Future<RoleList> getRoles(Map<String, dynamic> params) async {
    var uri = Uri.https(apiUrl, "/api/v1/roles", params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = RoleList.fromJson(res.data);
      return data;
    } catch (_) {
      throw _;
    }
  }

  static Future<List<Module>> getModules() async {
    var uri = Uri.https(apiUrl, "/api/v1/modules");
    var modules = <Module>[];

    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);

      for (var module in res.data) {
        modules.add(Module.fromJson(module));
      }
      return modules;
    } catch (_) {
      throw _;
    }
  }

  static Future<ApiResponse> createRole(
      CreateRole data, bool isUpdating) async {
    var uri = Uri.https(
        apiUrl, '/api/v1/roles/' + (isUpdating ? 'update' : 'create'));
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
      throw _;
    }
  }

  static Future<ApiResponse> deleteRole(String id) async {
    var uri = Uri.https(apiUrl, '/api/v1/roles/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: await headers);
      return res;
    } catch (_) {
      throw _;
    }
  }

  static bool hasPermission(List<Permission> permissions, String permissionId) {
    var result =
        permissions.where((permission) => permission.id == permissionId);

    if (result.length > 0) {
      return true;
    }
    return false;
  }

  /// PERMISSIONS

  static Future<PermissionsByModule> getPermissionByModule() async {
    var uri = Uri.https(apiUrl, '/api/v1/permissions/byModule');

    try {
      var response = await ApiClient.instance.get(uri, headers: await headers);
      return PermissionsByModule.fromJson(response.data);
    } catch (_) {
      throw _;
    }
  }
}
