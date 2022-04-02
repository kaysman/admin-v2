class ApiResponse<T> {
  final bool? success;
  final T? data;
  final int? code;
  final dynamic message;

  ApiResponse({this.success, this.data, this.message, this.code});

  static ApiResponse? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return ApiResponse(
      code: json["code"],
      success: json["status"],
      data: json["data"],
      message: json["message"],
    );
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, data: $data, code: $code, messages: $message)';
  }
}
