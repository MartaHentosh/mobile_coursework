import 'package:cours_work/data/services/admin_service.dart';

class AdminRepository {
  final AdminService _service = AdminService();

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final data = await _service.getUsers();
    return List<Map<String, dynamic>>.from(data);
  }

  Future<bool> deleteUser(int id) {
    return _service.deleteUser(id);
  }

  Future<bool> updateUser({
    required int userId,
    String? username,
    String? email,
    bool? isAdmin,
  }) {
    return _service.updateUser(
      userId: userId,
      username: username,
      email: email,
      isAdmin: isAdmin,
    );
  }
}
