import 'package:cours_work/data/repositories/admin_repository.dart';
import 'package:cours_work/data/services/local_storage.dart';
import 'package:flutter/material.dart';

class AdminUsersPage extends StatefulWidget {
  const AdminUsersPage({super.key});

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final AdminRepository _repo = AdminRepository();

  bool loading = true;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final isAdmin = await LocalStorage.getIsAdmin();

    if (!isAdmin) {
      setState(() {
        loading = false;
        users = [];
      });
      return;
    }

    final list = await _repo.fetchUsers();
    setState(() {
      users = list;
      loading = false;
    });
  }

  Future<void> _deleteUser(int id) async {
    final ok = await _repo.deleteUser(id);
    if (ok) {
      users.removeWhere((u) => (u['id'] as int) == id);
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Користувача видалено')));
      }
    }
  }

  Future<void> _editUser(Map<String, dynamic> user) async {
    final usernameController = TextEditingController(
      text: user['username'].toString(),
    );
    final emailController = TextEditingController(
      text: user['email'].toString(),
    );

    bool isAdmin = user['is_admin'] == 1;

    await showDialog<void>(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF023859),
            title: const Text(
              'Редагувати користувача',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Ім'я",
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                SwitchListTile(
                  value: isAdmin,
                  onChanged: (v) => setDialogState(() => isAdmin = v),
                  title: const Text(
                    'Адмін',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Закрити'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('Зберегти'),
                onPressed: () async {
                  await _repo.updateUser(
                    userId: user['id'] as int,
                    username: usernameController.text,
                    email: emailController.text,
                    isAdmin: isAdmin,
                  );

                  if (mounted) Navigator.pop(context);
                  _loadUsers();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocalStorage.getIsAdmin(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFF001C2A),
            body: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.data == false) {
          return const Scaffold(
            backgroundColor: Color(0xFF001C2A),
            body: Center(
              child: Text(
                'У вас немає доступу',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF001C2A),
          appBar: AppBar(
            backgroundColor: const Color(0xFF023859),
            title: const Text(
              'Адмін — Користувачі',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: loading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : ListView.builder(
                  itemCount: users.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, i) {
                    final u = users[i];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF023859),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${u['username']} (${u['email']})\nID: ${u['id']} | Admin: ${u['is_admin']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.amber),
                            onPressed: () => _editUser(u),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => _deleteUser(u['id'] as int),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
