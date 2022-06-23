import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/file-upload/file-upload.model.dart';
import 'package:lng_adminapp/data/services/api_client.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:lng_adminapp/shared.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
// import 'dart:io';
import 'package:universal_io/io.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

class FileUploadService {
  static Future<dynamic> uploadFile(
      FileUpload data, FilePickerResult file) async {
    var uri = Uri.https(apiUrl, '/api/v1/uploads/file');
    // String fileName = basename(file.path);
    // Dio dio = Dio();
    try {
      // var request = ApiClient.instance
      var request = http.MultipartRequest('POST', uri);
      request.headers['Content-type'] = 'multipart/form-data';
      // request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = 'Bearer ${await getToken()}';
      request.headers['x-timezone'] = await getTimezone();

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.files.single.path!,
        ),
      );

      var response = await request.send();
      return response;
    } catch (error) {}
  }
}
