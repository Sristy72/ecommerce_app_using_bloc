import 'package:ecommerce_app_using_bloc/core/di/injection.dart';
import 'package:ecommerce_app_using_bloc/core/network/service/auth_storage_service.dart';
import 'package:ecommerce_app_using_bloc/features/auth/screens/login_screen.dart';
import 'package:ecommerce_app_using_bloc/navigation_menu/main_screen_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authStorageService = getIt<AuthStorageService>();
    final isLoggedIn = await authStorageService.isLoggedIn();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isLoggedIn ? const MainScreenView() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
      ),
    );
  }
}
