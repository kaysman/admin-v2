import 'dart:convert';

import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/shared.dart';

class DriversService {
  static Future<User> createDriver(Map<String, dynamic> data) async {
    var uri = Uri.https(apiUrl, '/api/v1/');

    try {
      var res = await ApiClient.instance.post(
        uri,
        headers: await headers,
        data: jsonEncode(data),
      );
      return User.fromJson(res.data);
    } catch (_) {
      throw _;
    }
  }
}
