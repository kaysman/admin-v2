import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lng_adminapp/data/enums/status.enum.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/orders/order-column.dart';
import 'package:lng_adminapp/data/models/orders/order.model.dart';
import 'package:lng_adminapp/data/models/orders/get-mapping.model.dart';
import 'package:lng_adminapp/data/models/orders/mapping-response.model.dart';
import 'package:lng_adminapp/data/models/orders/single-order-upload.model.dart';
import 'package:lng_adminapp/data/models/shared/ids.model.dart';
import 'package:lng_adminapp/data/models/task/create-task.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:lng_adminapp/shared.dart';
import 'dart:html' as html;
import 'app.service.dart';

class OrderService {
  static final selectedOrder = ValueNotifier<Map<String, dynamic>?>(null);
  static final currentPage = ValueNotifier<String?>(null);

  // Returns orders associated with Tenant
  static Future<Map<String, dynamic>> getOrders(
      Map<String, dynamic> params) async {
    // Map<String, String> urlParameters = {};
    var fullPath = "https://" + apiUrl + "/api/v1/orders?";
    params.forEach((key, value) {
      if (value != null && (value.toString().isNotEmpty)) {
        fullPath += fullPath.endsWith('?') ? '' : '&';
        fullPath += '$key=$value';
      }
      ;
    });
    print(fullPath);
    var uri = Uri.parse(fullPath);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return res.data;
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching orders',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<Order> getOrderbyID(String id) async {
    var uri = Uri.https(apiUrl, "/api/v1/orders/$id");
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return Order.fromJson(res.data);
    } catch (_) {
      throw _;
    }
  }

  static Future<List<OrderColumn>?> getTableColumns(bool isDefault) async {
    var uri = Uri.https(
        apiUrl,
        "/api/v1/orders/" +
            (isDefault ? "defaultOrderTableColumns" : "allOrderTableColumns"));
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      if (res.data != null) {
        List<OrderColumn>? result = List<String>.from(res.data)
            .map((String e) => OrderColumn(e))
            .toList();
        return result;
      }
      return null;
    } catch (_) {
      throw _;
    }
  }

  static Future<ApiResponse> createSingleOrder(
      SingleOrderUploadModel data) async {
    var uri = Uri.https(apiUrl, '/api/v1/orders/create');
    var response;
    print(jsonEncode(data.toJson()));
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

  static Future<ApiResponse> updateSingleOrder(
      UpdateSingleOrderModel data) async {
    var uri = Uri.https(apiUrl, '/api/v1/orders/update');
    print(jsonEncode(data.toJson()));
    try {
      var response = await ApiClient.instance.patch(
        uri,
        headers: await headers,
        data: jsonEncode(data.toJson()),
      );
      return response;
    } catch (_) {
      throw _;
    }
  }

  static Future<ApiResponse> getMapping(GetMapping data) async {
    var uri = Uri.https(apiUrl, '/api/v1/orders/mapping/generate');
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
    var uri = Uri.https(apiUrl, '/api/v1/orders/create/multiple');

    print(json.encode(data.toJson()));
    try {
      var response = await ApiClient.instance.post(
        uri,
        headers: await headers,
        data: json.encode(data.toJson()),
      );
      return response;
    } catch (_) {
      throw _;
    }
  }

  static Future<bool> printShippingLabels(ListOfIds data) async {
    var uri = Uri.https(apiUrl, '/api/v1/orders/awb/download');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/octet-stream',
      'Authorization': 'Bearer ${await getToken()}'
    };
    Response res = await post(
      uri,
      headers: headers,
      body: json.encode(data.toJson()),
    );

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
    var uri = Uri.https(apiUrl, "/api/v1/orders");
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

  static Future<bool> assignDriver(CreateTaskEntity createTaskEntity) async {
    late Uri uri;
    if (createTaskEntity.relationToWhichSpecificTaskRelatedStatus ==
        TaskRelatedWorkflowSteps.ON_VEHICLE_FOR_DELIVERY)
      uri = Uri.https(apiUrl,
          "/api/v1/tasks/create/tenant/delivery-related-pick-up-and-drop-off");
    else
      uri = Uri.https(apiUrl,
          "/api/v1/tasks/create/tenant/non-delivery-related-pick-up-and-drop-off");

    try {
      var res = await ApiClient.instance.post(
        uri,
        data: json.encode(createTaskEntity.toJson()),
        headers: await headers,
      );

      return res.success ?? false;
    } catch (_) {
      throw _;
    }
  }
}
