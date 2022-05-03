import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/workflow/standard_workflow.model.dart';
import 'package:lng_adminapp/data/models/workflow/workflow.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/shared.dart';
import '../../presentation/blocs/snackbar.bloc.dart';

class WorkflowService {
  static final selectedWorkflow = ValueNotifier<WorkflowEntity?>(null);

  static Future<List<WorkflowEntity>> getWorkflows() async {
    var uri = Uri.https(apiUrl, 'api/v1/workflows');
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return (res.data as List).map((e) => WorkflowEntity.fromJson(e)).toList();
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching workflows',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<WorkflowStandard> getStandardWorkflows() async {
    var uri = Uri.https(apiUrl, 'api/v1/workflows/standard-workflow-names/get');
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return WorkflowStandard.fromJson(res.data);
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching workflow standard names',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<WorkflowEntity> getWorkflowByID(String id) async {
    var uri = Uri.https(apiUrl, "api/v1/workflows/$id/standard");
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return WorkflowEntity.fromJson(res.data);
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching workflow by id',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future createWorkflow(Map<String, dynamic> body) async {
    var uri = Uri.https(apiUrl, "api/v1/workflows/create");
    try {
      body["serviceType"] = "LOCAL_PARCEL_LESSER_THAN_30KG";
      body["serviceLevel"] = "NEXT_DAY";
      var res = await ApiClient.instance.post(
        uri,
        headers: await headers,
        data: jsonEncode(body),
      );
      return res;
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed creating workflow',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future updateDetails(String id,
      {String? name, String? description}) async {
    var uri = Uri.https(apiUrl, "api/v1/workflows/updateDetails");
    var body = <String, String>{"id": id};
    if (name != null) body["name"] = name;
    if (description != null) body["description"] = description;
    try {
      var res = await ApiClient.instance.patch(
        uri,
        headers: await headers,
        data: jsonEncode(body),
      );
      print(res.data);
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed updating workflow details',
          SnackbarType.error,
        );
      throw _;
    }
  }
}
