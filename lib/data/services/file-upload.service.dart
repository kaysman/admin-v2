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
    var uri = Uri.http(apiUrl, '/api/v1/uploads/file');
    // String fileName = basename(file.path);
    // Dio dio = Dio();
    try {
      // var request = ApiClient.instance
      var request = http.MultipartRequest('POST', uri);
      // print('${file.relativePath!}>>>> path');
      request.headers['Content-type'] = 'multipart/form-data';
      // request.headers['Accept'] = '*/*';
      request.headers['Authorization'] = 'Bearer ${await getToken()}';
      // request.fields['uploadType'] = data.uploadType!;
      // request.fields['name'] = 'data.name!';
      // request.files.add(http.MultipartFile(
      //   'file',
      //   file.readAsBytes().asStream(),
      //   file.lengthSync(),
      // ));
      // request.files.add(http.MultipartFile.fromBytes(
      //   'file',
      //   file.readAsBytesSync(),
      //   filename: file.path.split('/').last,
      // ));
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.files.single.path!,
        ),
      );
      print('4');
      print('we tried $request');

      var response = await request.send();

      print('$response >>>> this is the response');

      // Map<String, MultipartFile> fileMap = {};

      // var len = await file.length();
      // var response = await dio.post(
      //   uri,
      //   data: file.openRead(),
      //   options: Options(headers: {
      //     Headers.contentLengthHeader: len,
      //     'Authorization': 'Bearer ${await getToken()}'
      //   } // set content-length
      //       ),
      // );

      print('$response >>>> success response');
      return response;
    } catch (error) {
      print('error >>>>>> $error');
    }

    // print()
  }
  // static Future<Map<String, String>> get headers async => {
  //       "Content-Type": "application/json",
  //       "Accept": "*/*",
  //       "Authorization": 'Bearer ${await getToken()}',
  //     };

  // static Future<ApiResponse> uploadFile() async {
  //   var uri = Uri.http(apiUrl, '/api/v1/uploads/file');

  //   try {
  //     var res = await ApiClient.instance
  //         .post(uri, headers: await headers, data: jsonEncode());
  //   } catch (error) {}
  // }
}
