import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:path/path.dart';
import 'package:lng_adminapp/data/models/credentials.dart';
import 'package:lng_adminapp/data/models/file-upload/file-upload.model.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'package:universal_io/io.dart';
import 'api_client.dart';
import 'app.service.dart';

class LngService {
  static Future<Map<String, String>> get fileHeader async => {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${await getToken()}',
        "x-timezone": await getTimezone(),
      };

  static Future<Credentials> login(Map<String, dynamic> data) async {
    var uri = Uri.https(apiUrl, "/api/v1/auth/login");
    try {
      var res = await ApiClient.instance.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
            "x-timezone": await getTimezone(),
          },
          data: jsonEncode(data));
      return Credentials.fromJson(res.data);
    } catch (_) {
      throw _;
    }
  }

  /// Returns a UserIdentity object fetched
  /// from the api, data is non-nullable
  static Future<User> getUserIdentity(String? id) async {
    assert(id != null);
    var uri = Uri.https(apiUrl, "/api/v1/users/$id");
    try {
      var res = await ApiClient.instance.get(uri, headers: await headers);
      return User.fromJson(res.data);
    } on HttpException catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching user identity',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<User> updateUserIdentity(Map<String, dynamic> data) async {
    var uri = Uri.https(apiUrl, "/api/v1/users/update");
    print(jsonEncode(data));
    try {
      var res = await ApiClient.instance
          .patch(uri, headers: await headers, data: jsonEncode(data));
      if (res.success == true) {
        AppService.showSnackbar!(
          'Successfully updated',
          SnackbarType.success,
        );
      }
      // print(res.data);

      return User.fromJson(res.data);
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed updating user',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<dynamic> uploadFile(
      FileUpload data, FilePickerResult result) async {
    Uint8List _bytesData = result.files.last.bytes!;
    String fileName = basename(result.files.last.path!);
    var uri = Uri.https(apiUrl, '/api/v1/uploads/file');
    try {
      var response = ApiClient.instance.sendFile(uri, _bytesData, fileName,
          data: data, headers: await fileHeader);
      return response;
    } catch (error) {}
  }

  static Future<bool?> changePassword(
      String oldPassword, String newPassword) async {
    var uri = Uri.https(apiUrl, "/api/v1/auth/change-password");
    var body = <String, String>{
      "oldPassword": oldPassword,
      "newPassword": newPassword
    };
    try {
      var res = await ApiClient.instance
          .patch(uri, data: json.encode(body), headers: await headers);

      return res.success;
    } catch (_) {
      throw _;
    }
  }
}
