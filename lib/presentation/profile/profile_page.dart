import 'package:cours_work/data/repositories/profile_repository.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileRepository _repo = ProfileRepository();

  String username = 'User';
  int bonuses = 0;
  bool isAdmin = false;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await _repo.getProfile();

      final String name = (profile['username'] ?? '').toString();
      final int id = (profile['user_id'] as int);

      final bool admin = name.toLowerCase() == 'administrator' || id == 1;

      await LocalStorage.saveIsAdmin(admin);

      setState(() {
        username = name;
        bonuses = 0;
        isAdmin = admin;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user_id');
    await prefs.remove('is_admin');

    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001C2A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF023859),
        title: const Text('Профіль', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFA7EBF2),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Бонуси: $bonuses',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _profileButton('Мої вподобання'),
                    _profileButton('Моя адреса'),
                    _profileButton('Преміум підписка'),

                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profileOrders),
                      child: _profileButton('Історія замовлень'),
                    ),

                    if (isAdmin) ...[
                      const SizedBox(height: 30),
                      const Text(
                        'Адмін панель',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.adminUsers),
                        child: _profileButton('Керування користувачами'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _profileButton(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF023859),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFA7EBF2),
            blurRadius: 15,
            spreadRadius: -5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
