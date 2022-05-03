import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/location/location-request.model.dart';
import 'package:lng_adminapp/data/models/location/location.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/app.service.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';

class LocationService {
  static final selectedLocation = ValueNotifier<Location?>(null);

  static Future<ApiResponse> createLocation(
      LocationRequest data, bool isUpdating) async {
    var uri = Uri.https(apiUrl, '/api/v1/warehouses');
    var response;
    try {
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
    } catch (_) {
      throw _;
    }

    return response;
  }

  static Future<LocationList> getLocations(Map<String, String> params) async {
    var uri = Uri.https(apiUrl, '/api/v1/warehouses', params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = LocationList.fromJson(res.data);

      return data;
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching locations',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<ApiResponse> deleteLocation(String id) async {
    var uri = Uri.https(apiUrl, '/api/v1/warehouses/$id');
    try {
      var res = await ApiClient.instance.delete(uri, headers: await headers);
      return res;
    } catch (_) {
      throw _;
    }
  }
}
