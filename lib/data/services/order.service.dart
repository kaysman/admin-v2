import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/get-mapping.model.dart';
import 'package:lng_adminapp/data/models/orders/mapping-response.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/shared/ids.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'dart:html' as html;
import 'app.service.dart';

class OrderService {
  static final selectedOrder = ValueNotifier<Order?>(null);
  static final currentPage = ValueNotifier<String?>(null);

  // Returns orders associated with Tenant
  static Future<OrderList> getOrders(Map<String, dynamic> params) async {
    print(params);
    var uri = Uri.http(apiUrl, "/api/v1/orders", params);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      var data = OrderList.fromJson(res.data);
      return data;
    } catch (_) {
      print(_.toString());
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching orders',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<ApiResponse> createSingleOrder(
      SingleOrderUploadModel data) async {
    var uri = Uri.http(apiUrl, '/api/v1/orders/create');
    var response;
    try {
      print(jsonEncode(data.toJson()));
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

  static Future<ApiResponse> updateSingleOrder(
      UpdateSingleOrderModel data) async {
    var uri = Uri.http(apiUrl, '/api/v1/orders/update');
    try {
      print(jsonEncode(data.toJson()));
      var response = await ApiClient.instance.patch(
        uri,
        headers: await headers,
        data: jsonEncode(data.toJson()),
      );
      print(response.data);
      return response;
    } catch (_) {
      throw _;
    }
  }

  static Future<ApiResponse> getMapping(GetMapping data) async {
    var uri = Uri.http(apiUrl, '/api/v1/orders/mapping/generate');
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

  static Future<ApiResponse> createMultipleOrders(
      FilledMappingRequest data) async {
    var uri = Uri.http(apiUrl, '/api/v1/orders/create/multiple');
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

  static Future<bool> printShippingLabels(ListOfIds data) async {
    var uri = Uri.http(apiUrl, '/api/v1/orders/awb/download');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/octet-stream',
      'Authorization': 'Bearer ${await getToken()}'
    };
    Response res =
        await post(uri, headers: headers, body: jsonEncode(data.toJson()));

    if (res.statusCode == 201) {
      final blob = html.Blob([res.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'shipping-label.pdf';
      html.document.body?.children.add(anchor);

      anchor.click();

      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
      return true;
    }

    return false;
  }

  static Future<ApiResponse> deleteMultipleOrders(List<String> IDs) async {
    var uri = Uri.http(apiUrl, "/api/v1/orders");
    var jsonString = jsonEncode({"ids": IDs});
    try {
      var res = await ApiClient.instance.delete(
        uri,
        headers: await headers,
        data: jsonString,
      );
      return res;
    } catch (_) {
      throw _;
    }
  }
}
