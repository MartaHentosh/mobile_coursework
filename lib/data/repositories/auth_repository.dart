import 'package:cours_work/data/services/api_client.dart';
import 'package:cours_work/data/services/auth_service.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final _api = AuthService();

  Future<String> login({
    required String username,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final res = await _api.login(username: username, password: password);

      final token = res.data?['access_token']?.toString();
      if (token == null || token.isEmpty) {
        throw Exception('Не вдалося отримати токен доступу.');
      }

      if (rememberMe) {
        await LocalStorage.saveToken(token);
      }

      await ApiClient.setToken();

      return token;
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final detail = e.response?.data is Map
          ? e.response?.data['detail']?.toString()
          : null;
      if (code == 401) throw Exception('Невірний логін або пароль.');
      if (code == 400 && detail != null) throw Exception(detail);
      if (code == 500) throw Exception('Помилка сервера. Спробуйте пізніше.');
      throw Exception(
        detail ?? 'Помилка мережі. Перевірте інтернет і спробуйте ще.',
      );
    } catch (_) {
      throw Exception('Сталася невідома помилка. Спробуйте ще раз.');
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _api.register(username: username, email: email, password: password);
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final detail = e.response?.data is Map
          ? e.response?.data['detail']?.toString()
          : null;
      if (code == 400 && detail != null) throw Exception(detail);
      if (code == 500) throw Exception('Помилка сервера. Спробуйте пізніше.');
      throw Exception(
        detail ?? 'Помилка мережі. Перевірте інтернет і спробуйте ще.',
      );
    } catch (_) {
      throw Exception('Сталася невідома помилка. Спробуйте ще раз.');
    }
  }
}
