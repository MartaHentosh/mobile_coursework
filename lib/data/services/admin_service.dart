import 'package:cours_work/data/services/api_client.dart';
import 'package:dio/dio.dart';

class AdminService {
  final Dio _dio = ApiClient.dio;

  Future<List<dynamic>> getUsers() async {
    final Response res = await _dio.get('/admin/users');

    if (res.data is List) {
      return res.data as List<dynamic>;
    }
    return [];
  }

  Future<bool> deleteUser(int userId) async {
    final Response res = await _dio.delete('/admin/users/$userId');

    return res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300;
  }

  Future<bool> updateUser({
    required int userId,
    String? username,
    String? email,
    bool? isAdmin,
  }) async {
    final Response res = await _dio.put(
      '/admin/users/$userId',
      queryParameters: {
        if (username != null) 'username': username,
        if (email != null) 'email': email,
        if (isAdmin != null) 'is_admin': isAdmin ? 1 : 0,
      },
    );

    return res.statusCode != null && res.statusCode! >= 200 && res.statusCode! < 300;
  }
}
