import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get_connect/http/src/response/response.dart' as get_connect;
import 'package:http/http.dart' as http;

abstract class IApiClient {
  Future<get_connect.Response> getReq(
    String endpoint, {
    String? contentType,
    Map<String, String>? queryParams,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  Future<get_connect.Response> postReq(
    String endpoint,
    dynamic body, {
    String? contentType,
    dynamic Function(double)? uploadProgress,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  Future<get_connect.Response> patchReq(
    String endpoint,
    dynamic body, {
    String? contentType,
    dynamic Function(double)? uploadProgress,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  Future<get_connect.Response> deleteReq<T>(
    String endpoint, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    T Function(dynamic)? decoder,
  });

  Future<get_connect.Response> putReq<T>(
    String endpoint,
    dynamic body, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    T Function(dynamic)? decoder,
    dynamic Function(double)? uploadProgress,
  });
  Future<File?> downloadFile(
    String url, {
    required String pathToSave,
  });
}

class ApiClient implements IApiClient {
  ApiClient({required dio.Dio dio, required String baseURL})
      : _dio = dio,
        _baseURL = baseURL;

  final dio.Dio _dio;
  final String _baseURL;

  String get url => _baseURL;
  final http.Client client = http.Client();

  get_connect.Response _fromDio(dio.Response<dynamic> dioResponse) {
    return get_connect.Response(
      body: dioResponse.data,
      statusCode: dioResponse.statusCode,
      statusText: dioResponse.statusMessage ?? '',
    );
  }

  @override
  Future<get_connect.Response> getReq(
    String endpoint, {
    String? contentType,
    Map<String, String>? queryParams,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final r = await _dio.get<dynamic>(
        endpoint,
        queryParameters: query,
        options: dio.Options(
          contentType: contentType,
          headers: headers,
        ),
      );
      return _fromDio(r);
    } on dio.DioException catch (e) {
      return get_connect.Response(
        statusCode: e.response?.statusCode ?? -1,
        statusText: e.message ?? e.response?.statusMessage ?? '',
        body: e.response?.data,
      );
    }
  }

  @override
  Future<get_connect.Response> postReq(
    String endpoint,
    dynamic body, {
    String? contentType,
    dynamic Function(double)? uploadProgress,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final r = await _dio.post<dynamic>(
        endpoint,
        data: body,
        queryParameters: query,
        options: dio.Options(
          contentType: contentType,
          headers: headers,
        ),
        onSendProgress: uploadProgress != null
            ? (sent, total) => uploadProgress(total > 0 ? sent / total : 0)
            : null,
      );
      return _fromDio(r);
    } on dio.DioException catch (e) {
      return get_connect.Response(
        statusCode: e.response?.statusCode ?? -1,
        statusText: e.message ?? e.response?.statusMessage ?? '',
        body: e.response?.data,
      );
    }
  }

  @override
  Future<get_connect.Response> patchReq(
    String endpoint,
    dynamic body, {
    String? contentType,
    dynamic Function(double)? uploadProgress,
    dynamic Function(dynamic)? decoder,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    try {
      final r = await _dio.patch<dynamic>(
        endpoint,
        data: body,
        queryParameters: query,
        options: dio.Options(
          contentType: contentType,
          headers: headers,
        ),
        onSendProgress: uploadProgress != null
            ? (sent, total) => uploadProgress(total > 0 ? sent / total : 0)
            : null,
      );
      return _fromDio(r);
    } on dio.DioException catch (e) {
      return get_connect.Response(
        statusCode: e.response?.statusCode ?? -1,
        statusText: e.message ?? e.response?.statusMessage ?? '',
        body: e.response?.data,
      );
    }
  }

  @override
  Future<get_connect.Response> deleteReq<T>(
    String endpoint, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    T Function(dynamic)? decoder,
  }) async {
    try {
      final r = await _dio.delete<dynamic>(
        endpoint,
        queryParameters: query,
        options: dio.Options(
          contentType: contentType,
          headers: headers,
        ),
      );
      return _fromDio(r);
    } on dio.DioException catch (e) {
      return get_connect.Response(
        statusCode: e.response?.statusCode ?? -1,
        statusText: e.message ?? e.response?.statusMessage ?? '',
        body: e.response?.data,
      );
    }
  }

  @override
  Future<get_connect.Response> putReq<T>(
    String endpoint,
    dynamic body, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    T Function(dynamic)? decoder,
    dynamic Function(double)? uploadProgress,
  }) async {
    try {
      final r = await _dio.put<dynamic>(
        endpoint,
        data: body,
        queryParameters: query,
        options: dio.Options(
          contentType: contentType,
          headers: headers,
        ),
        onSendProgress: uploadProgress != null
            ? (sent, total) => uploadProgress(total > 0 ? sent / total : 0)
            : null,
      );
      return _fromDio(r);
    } on dio.DioException catch (e) {
      return get_connect.Response(
        statusCode: e.response?.statusCode ?? -1,
        statusText: e.message ?? e.response?.statusMessage ?? '',
        body: e.response?.data,
      );
    }
  }

  @override
  Future<File?> downloadFile(
    String url, {
    required String pathToSave,
  }) async {
    final req = await client.get(Uri.parse(url));
    final bytes = req.bodyBytes;
    final file = File(pathToSave);
    await file.writeAsBytes(bytes);
    return file;
  }
}

extension StreamListIntExtension on Stream<List<int>>? {
  Future<List<int>> toBytes() async {
    final List<int> result = [];
    await for (final chunk in this ?? const Stream.empty()) {
      result.addAll(chunk);
    }
    return result;
  }
}
