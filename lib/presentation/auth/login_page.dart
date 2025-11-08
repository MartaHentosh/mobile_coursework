import 'package:cours_work/data/repositories/auth_repository.dart';
import 'package:cours_work/navigation/app_routes.dart';
import 'package:cours_work/widgets/bluebite_checkbox.dart';
import 'package:cours_work/widgets/glow_button.dart';
import 'package:cours_work/widgets/glow_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool obscureText = true;
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
              height: 500,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF023859), Color(0xFF26658C)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0xFFA7EBF2),
                    blurRadius: 10,
                    spreadRadius: 0.8,
                    offset: Offset(0, 1),
                  ),
                  BoxShadow(
                    color: const Color(0xFFA7EBF2).withValues(alpha: 0.35),
                    blurRadius: 40,
                    spreadRadius: -10,
                    offset: const Offset(0, 30),
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
                    const SizedBox(height: 60),
                    const Text(
                      'Вхід',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFA7EBF2),
                      ),
                    ),
                    const SizedBox(height: 32),

                    GlowInput(controller: emailController, hint: 'Пошта'),
                    const SizedBox(height: 20),

                    GlowInput(
                      controller: passwordController,
                      hint: 'Пароль',
                      obscureText: obscureText,
                      icon: obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onIconTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        BlueBiteCheckbox(
                          value: rememberMe,
                          onChanged: (val) => setState(() => rememberMe = val),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Запам’ятати мене',
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 150),
                    GlowButton(
                      text: loading ? 'Завантаження...' : 'Увійти',
                      isPrimary: false,
                      height: 42,
                      width: 220,
                      onPressed: loading
                          ? null
                          : () async {
                              setState(() => loading = true);

                              try {
                                await AuthRepository().login(
                                  username: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );

                                if (!mounted) return;
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.home,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Помилка входу: $e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                if (mounted) setState(() => loading = false);
                              }
                            },
                    ),
                    const SizedBox(height: 80),

                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: const Text(
                        'Немає облікового запису?\nЗареєструватися',
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
