import 'dart:convert';

import 'package:lng_adminapp/shared.dart';
import 'api_client.dart';

class EnumHandlingService {
  static Future<List<String>> getEnumTypes() async {
    var uri = Uri.https(apiUrl, '/api/v1/enum-handling/enumTypes');
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return res.data;
    } catch (_) {
      throw _;
    }
  }

  static Future<List<String>> getEnumsByType(String key) async {
    var uri = Uri.https(apiUrl, '/api/v1/enum-handling/single/$key');
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return List<String>.from(res.data);
    } catch (_) {
      throw _;
    }
  }

  static Future<Map<String, dynamic>> getEnumsByMultipleTypes(
    List<String> keys,
  ) async {
    var pathParams = {'enumsRequired[]': keys};
    var uri = Uri.https(apiUrl, '/api/v1/enum-handling/multiple', pathParams);
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return res.data;
    } catch (_) {
      throw _;
    }
  }
}
