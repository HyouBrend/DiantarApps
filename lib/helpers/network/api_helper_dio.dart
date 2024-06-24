import 'package:dio/dio.dart';
import 'api_helper.dart';

class ApiHelperImpl extends ApiHelper {
  final Dio dio;

  ApiHelperImpl({required this.dio}) {
    initDio();
  }

  Dio initDio() {
    return dio;
  }

  @override
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      print('Sending GET request to: $url');
      Response response = await dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      if (e.type == DioErrorType.connectTimeout) {
        print('Connection Timeout Error');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Receive Timeout Error');
      } else if (e.type == DioErrorType.response) {
        print('Response Error: ${e.response?.data}');
      } else if (e.type == DioErrorType.other) {
        print('Other Error: ${e.message}');
      }
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending POST request to: $url with body: $body');
      Response response = await dio.post(
        url,
        data: body,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      if (e.type == DioErrorType.connectTimeout) {
        print('Connection Timeout Error');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Receive Timeout Error');
      } else if (e.type == DioErrorType.response) {
        print('Response Error: ${e.response?.data}');
      } else if (e.type == DioErrorType.other) {
        print('Other Error: ${e.message}');
      }
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> patch({
    required String url,
    required dynamic body,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending PATCH request to: $url with body: $body');
      Response response = await dio.patch(
        url,
        data: body,
        options: options,
        queryParameters: queryParameters,
      );
      print('Response received: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      if (e.type == DioErrorType.connectTimeout) {
        print('Connection Timeout Error');
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Receive Timeout Error');
      } else if (e.type == DioErrorType.response) {
        print('Response Error: ${e.response?.data}');
      } else if (e.type == DioErrorType.other) {
        print('Other Error: ${e.message}');
      }
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> downloadUri({
    required String url,
    required dynamic body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending DOWNLOAD request to: $url with body: $body');
      final Response response = await dio.downloadUri(
        Uri.parse(url),
        body,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<Response> getImage({
    required String url,
    Options? options,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('Sending GET IMAGE request to: $url');
      final Response response = await dio.get(
        url,
        options: options,
      );
      print('Response received: ${response.data}');
      return response;
    } on DioError catch (e) {
      print('DioError: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } on Exception {
      rethrow;
    }
  }
}
