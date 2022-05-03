import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:lng_adminapp/data/models/user.model.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:path/path.dart';
import 'package:lng_adminapp/data/models/credentials.dart';
import 'package:lng_adminapp/data/models/file-upload/file-upload.model.dart';
import 'package:lng_adminapp/presentation/blocs/snackbar.bloc.dart';
import 'api_client.dart';
import 'app.service.dart';

class LngService {
  static Future<Map<String, String>> get fileHeader async => {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${await getToken()}',
      };

  static Future<Credentials> login(Map<String, dynamic> data) async {
    var uri = Uri.https(apiUrl, "/api/v1/auth/login");
    try {
      var res = await ApiClient.instance.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": "*/*",
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
    } catch (_) {
      if (!AppService.httpRequests!.state.requests.contains(uri.path))
        AppService.showSnackbar!(
          'Failed fetching user identity',
          SnackbarType.error,
        );
      throw _;
    }
  }

  static Future<User> updateUserIdentity(Map<String, dynamic> data) async {
    var uri = Uri.https(apiUrl, "/api/v1/users");
    try {
      var res = await ApiClient.instance.patch(
        uri,
        headers: {"Authorization": 'Bearer ${await getToken()}'},
        data: jsonEncode(data),
      );
      return User.fromJson(res.data);
    } catch (_) {
      print(_.toString());
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
      print(res);
      return res.success;
    } catch (_) {
      print(_.toString());
      throw _;
    }
  }
}
