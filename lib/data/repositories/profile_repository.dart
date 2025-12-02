import 'package:cours_work/data/services/profile_service.dart';

class ProfileRepository {
  final ProfileService _service = ProfileService();

  Future<Map<String, dynamic>> getProfile() async {
    return await _service.getProfile();
  }

  Future<List<dynamic>> getOrderHistory() async {
    return await _service.getOrderHistory();
  }
}
