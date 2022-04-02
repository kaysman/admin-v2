import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as defaultHttp;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lng_adminapp/data/models/api_response.dart';
import 'package:lng_adminapp/data/models/credentials.dart';
import 'package:lng_adminapp/data/services/storage.service.dart';
import 'package:universal_io/io.dart';
import 'app.service.dart';

class ApiClient {
  static defaultHttp.Client? http;
  // static Future? refreshing;

  static interceptorClient() {
    return InterceptedClient.build(
      requestTimeout: const Duration(milliseconds: 15000),
      interceptors: [BearerTokenApiInterceptor()],
      client: BrowserClient(),
      // use dart:io for mobile
      // IOClient(
      //   HttpClient()..badCertificateCallback = (cert, host, port) => true,
      // ),
    );
  }

  // lazy-load client
  ApiClient._setInstance() {
    http = http ?? interceptorClient();
  }
  static final ApiClient instance = ApiClient._setInstance();

  // resets client connection
  static reset() {
    AppService.httpRequests!.clear();
    http!.close();
    http = interceptorClient();
  }

  ///
  /// [IN-MEMORY CREDENTIALS]
  ///

  static Credentials? _credentials;
  static Future<Credentials?> get credentials async {
    if (_credentials == null) {
      var disk = await LocalStorage.instance;
      setCredentials(disk.credentials);
      if (_credentials == null) AppService.onAuthError!();
    }
    return _credentials;
  }

  static setCredentials(Credentials? cred) {
    _credentials = cred;
  }

  ///
  /// [Headers, ApiResponse]
  ///

  Future<ApiResponse> put(Uri uri,
      {Map<String, String> headers = const {},
      dynamic data,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'PUT', uri, data: data, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> patch(Uri uri,
      {Map<String, String> headers = const {},
      dynamic data,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'PATCH', uri, data: data, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> post(Uri uri,
      {Map<String, String> headers = const {},
      dynamic data,
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'POST', uri, data: data, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> get(Uri uri,
      {dynamic data,
      Map<String, String> headers = const {},
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'GET', uri, headers: headers),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> delete(Uri uri,
      {dynamic data,
      Map<String, String> headers = const {},
      bool anonymous = false}) async {
    try {
      return await sendWithRetry(
        ClientRequest(http!, 'DELETE', uri, headers: headers, data: data),
      );
    } catch (_) {
      throw _;
    }
  }

  Future<ApiResponse> sendFile(Uri uri, dynamic file, String filename,
      {Map<String, String> headers = const {},
      dynamic data,
      bool anonymous = false}) async {
    try {
      var client = defaultHttp.Client();
      return await sendFileWithRetry(
          ClientRequest(client, 'POST', uri, data: data, headers: headers),
          file,
          filename);
    } catch (_) {
      throw _;
    }
  }

  ///
  /// [RETRY] file send
  ///
  Future<ApiResponse> sendFileWithRetry(
      ClientRequest req, List<int> selectedFile, String filename,
      {int maxRetries = 3}) async {
    AppService.httpRequests!.add(req.uri.path);
    DateTime start = DateTime.now();
    int retries = 0;

    while (DateTime.now().difference(start).abs() <
            Duration(milliseconds: 10000) &&
        retries < maxRetries) {
      try {
        final response = req.sendFile(selectedFile, filename).then((res) {
          print('about to start');
          if (res.statusCode == 200) {
            print('response');
            AppService.httpRequests!.remove(req.uri.path);
            return ApiResponse(
              code: 200,
              message: "Uploaded",
            );
          } else {
            print('response 2');
            throw HttpException(
              '${res.statusCode} | ${res.reasonPhrase} | ${res}',
            );
          }
        });
      } on SocketException catch (e) {
        print('No Internet connection 😑');
        handleException(req, 'SocketException', e.toString(), retries);
      } on HttpException catch (e) {
        print("Couldn't find the post 😱");
        handleException(req, 'HttpException', e.toString(), retries);
      } on FormatException catch (e) {
        print("Bad response format 👎");
        handleException(req, 'FormatException', e.toString(), retries);
      } on HandshakeException catch (e) {
        print("Bad handshake 👎");
        handleException(req, 'HandshakeException', e.toString(), retries);
      } on defaultHttp.ClientException catch (_) {
        print("Client was reset");
        AppService.httpRequests!.remove(req.uri.path);
        throw defaultHttp.ClientException("Client was reset");
      } catch (_) {
        print(_.toString());
        print("👎👎👎👎👎👎 1");
        handleException(req, 'Exception', _.toString(), retries);
      } finally {
        retries++;
        await Future.delayed(
          Duration(
            milliseconds: (100 * pow(2, retries).toInt()),
          ),
        );
      }
    }
    print('request escaped');
    AppService.httpRequests!.remove(req.uri.path);
    throw TimeoutException("Client timeout");
  }
}

handleException(ClientRequest req, String type, String e, retries) {
  print("Error: $e");
  var details = jsonEncode({
    "retry": retries,
    "error": e,
  });
}

///
/// [RETRY]
///
Future<ApiResponse> sendWithRetry(ClientRequest req,
    {int maxRetries = 3}) async {
  AppService.httpRequests!.add(req.uri.path);
  DateTime start = DateTime.now();
  int retries = 0;

  // while (
  //     DateTime.now().difference(start).abs() < Duration(milliseconds: 60000) &&
  //         retries < maxRetries) {
  try {
    print('send it');
    print(req.uri.path);
    final response = await req.send();

    var data = ApiResponse.fromJson(jsonDecode(response.body));

    if (data != null && data.success == true) {
      AppService.httpRequests!.remove(req.uri.path);
      return data;
    } else {
      throw HttpException(
        '${response.statusCode} | ${response.reasonPhrase} | ${response.body}',
      );
    }
  } on SocketException catch (e) {
    print('No Internet connection 😑');
    handleException(req, 'SocketException', e.toString(), retries);
  } on HttpException catch (e) {
    print("Couldn't find the post 😱");
    handleException(req, 'HttpException', e.toString(), retries);
  } on FormatException catch (e) {
    print("Bad response format 👎");
    handleException(req, 'FormatException', e.toString(), retries);
  } on HandshakeException catch (e) {
    print("Bad handshake 👎");
    handleException(req, 'HandshakeException', e.toString(), retries);
  } on defaultHttp.ClientException catch (_) {
    print("Client was reset");
    AppService.httpRequests!.remove(req.uri.path);
    throw defaultHttp.ClientException("Client was reset");
  } catch (_) {
    print("👎👎👎👎👎👎 2");
    handleException(req, 'Exception', _.toString(), retries);
  } finally {
    retries++;
    await Future.delayed(
        Duration(milliseconds: (100 * pow(2, retries).toInt())));
  }
  // }
  print('request escaped');
  AppService.httpRequests!.remove(req.uri.path);
  throw TimeoutException("Client timeout");
}

// add credentials to non-anonymous headers
class BearerTokenApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    try {
      final cred = (await LocalStorage.instance).credentials;
      if (cred != null && cred.accessToken!.isNotEmpty) {
        data!.headers.addAll({"Authorization": 'Bearer ${cred.accessToken}'});
      } else {
        AppService.onAuthError!();
      }
    } catch (e) {
      print("Bearer token interceptor error: $e");
    }
    return data!;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async {
    return data!;
  }
}

class ClientRequest {
  final defaultHttp.Client client;
  final String method;
  final Uri uri;
  final Map<String, String>? headers;
  final dynamic data;

  ClientRequest(
    this.client,
    this.method,
    this.uri, {
    this.headers,
    this.data,
  });

  Future<defaultHttp.Response> send() async {
    switch (method) {
      case 'GET':
        return await client.get(uri, headers: headers);
      case 'POST':
        return await client.post(uri, headers: headers, body: data);
      case 'PUT':
        return await client.put(uri, headers: headers, body: data);
      case 'PATCH':
        return await client.patch(uri, headers: headers, body: data);
      case 'DELETE':
        return await client.delete(uri, headers: headers, body: data);
      default:
        return await client.get(uri, headers: headers);
    }
  }

  Future<defaultHttp.StreamedResponse> sendFile(
      List<int> selectedFile, String filename) async {
    var request = await defaultHttp.MultipartRequest(method, uri);
    request.fields.addAll(data);
    request.headers.addAll(headers!);
    request.files.add(
      defaultHttp.MultipartFile.fromBytes(
        'file',
        selectedFile,
        filename: filename,
        contentType: MediaType('application', 'octet-stream'),
      ),
    );

    return request.send();
  }
}
