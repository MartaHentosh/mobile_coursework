import 'package:cours_work/data/repositories/auth_repository.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/widgets/bluebite_checkbox.dart';
import 'package:cours_work/widgets/glow_button.dart';
import 'package:cours_work/widgets/glow_input.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool rememberMe = false;
  bool obscurePass1 = true;
  bool obscurePass2 = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF011C40), Color(0xFF023250)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 550,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF023859), Color(0xFF26658C)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFA7EBF2),
                    blurRadius: 10,
                    spreadRadius: 0.8,
                    offset: Offset(0, 1),
                  ),
                  BoxShadow(
                    color: Color(0x80A7EBF2),
                    blurRadius: 40,
                    spreadRadius: -10,
                    offset: Offset(0, 30),
                  ),
                ],
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    const Text(
                      'Реєстрація',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFA7EBF2),
                      ),
                    ),
                    const SizedBox(height: 32),

                    GlowInput(controller: usernameController, hint: 'Логін'),
                    const SizedBox(height: 20),

                    GlowInput(controller: emailController, hint: 'Пошта'),
                    const SizedBox(height: 20),

                    GlowInput(
                      controller: passwordController,
                      hint: 'Пароль',
                      obscureText: obscurePass1,
                      icon: obscurePass1
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onIconTap: () =>
                          setState(() => obscurePass1 = !obscurePass1),
                    ),
                    const SizedBox(height: 20),

                    GlowInput(
                      controller: confirmController,
                      hint: 'Повторити пароль',
                      obscureText: obscurePass2,
                      icon: obscurePass2
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onIconTap: () =>
                          setState(() => obscurePass2 = !obscurePass2),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        BlueBiteCheckbox(
                          value: rememberMe,
                          onChanged: (v) => setState(() => rememberMe = v),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Запам’ятати мене',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),

                    const SizedBox(height: 120),

                    GlowButton(
                      text: loading ? 'Завантаження...' : 'Зареєструватися',
                      isPrimary: false,
                      height: 42,
                      width: 250,
                      onPressed: loading
                          ? null
                          : () async {
                              if (passwordController.text !=
                                  confirmController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Паролі не співпадають!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              setState(() => loading = true);

                              try {
                                await AuthRepository().register(
                                  username: usernameController.text.trim(),
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Успішна реєстрація!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Помилка реєстрації: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                if (mounted) setState(() => loading = false);
                              }
                            },
                    ),
                    const SizedBox(height: 60),

                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login,
                      ),
                      child: const Text(
                        'Маєте акаунт? Увійти',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFA7EBF2),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
