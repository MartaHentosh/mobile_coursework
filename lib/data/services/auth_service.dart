import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://35.225.117.203:8000/',
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );

  Future<Response<dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    return await _dio.post(
      'auth/register',
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
  }

  Future<Response<dynamic>> login({
    required String username,
    required String password,
  }) async {
    return await _dio.post(
      'auth/login',
      data: FormData.fromMap({
        'username': username,
        'password': password,
      }),
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
  }
}
