import 'package:cours_work/data/services/local_storage.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000/',
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );

  static Future<void> setToken() async {
    final token = await LocalStorage.getToken();
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
