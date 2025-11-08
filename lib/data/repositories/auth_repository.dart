import 'package:cours_work/data/services/auth_service.dart';
import 'package:cours_work/data/services/local_storage.dart';


class AuthRepository {
  final _api = AuthService();

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final res = await _api.register(
      username: username,
      email: email,
      password: password,
    );
    print(res.data);
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final res = await _api.login(
      username: username,
      password: password,
    );

    print(res.data);

    final token = (res.data['access'] ?? res.data['token'])?.toString();

    if (token != null) {
      await LocalStorage.saveToken(token);
    }
  }
}
