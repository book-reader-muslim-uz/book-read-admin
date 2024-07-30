import 'package:dio/dio.dart';

class DioClient {
  final _dio = Dio();

  DioClient._private() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 5)
      ..receiveTimeout = const Duration(seconds: 3)
      ..baseUrl = "https://read-pdf-649e3-default-rtdb.firebaseio.com/";
  }

  static final _singletonConstructor = DioClient._private();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParams);

      return response;
    } catch (e) {
      print("Dio'da GET qilishda error bor: ");
      rethrow;
    }
  }

  Future<Response> add({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);

      return response;
    } catch (e) {
      print("Dioda POST qilishda errror bor: $e");
      rethrow;
    }
  }
}
