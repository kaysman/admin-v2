import 'dart:convert';

import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/pickup/approve-pickup-request.model.dart';
import 'package:lng_adminapp/data/models/pickup/create-pickup-request.model.dart';
import 'package:lng_adminapp/data/models/pickup/pickup.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class PickupService {
  // static String apiUrl = "lng-test-environment.as.r.appspot.com";
  // static final selectedPickup = ValueNotifier<Team?>(null);
  static Future<Map<String, String>> get headers async => {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Authorization": 'Bearer ${await getToken()}',
      };
  static Future<String?> getToken() async {
    var disk = (await LocalStorage.instance);
    return disk.credentials?.accessToken;
  }

  static Future<ApiResponse> createPickupRequest(
      CreatePickupRequest data) async {
    var uri = Uri.http(apiUrl, '/api/v1/requests');
    var response;
    try {
      response = await ApiClient.instance.post(
        uri,
        headers: await headers,
        data: jsonEncode(data.toJson()),
      );
    } catch (_) {
      throw _;
    }

    return response;
  }

  static Future<ApiResponse> approvePickupRequest(
      ApproveRequestModel data) async {
    var uri = Uri.http(apiUrl, '/api/v1/requests/approve');
    var response;
    try {
      response = await ApiClient.instance.post(
        uri,
        headers: await headers,
        data: jsonEncode(data.toJson()),
      );
    } catch (_) {
      print('$_ >>>> res');
      throw _;
    }

    return response;
  }

  // Returns pickups associated with Tenant
  static Future<PickupList> getPickups(Map<String, String> params) async {
    var uri = Uri.http(apiUrl, "/api/v1/requests", params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = PickupList.fromJson(res.data);
      return data;
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching pickups',
          SnackbarType.error,
        );
      throw _;
    }
  }
}
