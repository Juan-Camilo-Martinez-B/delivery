import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF7A86),
              AppColors.primary,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "Foodgo",
                textAlign: TextAlign.center,
                style: AppTextStyles.logo.copyWith(color: AppColors.white, fontSize: 48),
              ),
            ),
            Positioned(
              left: -8,
              bottom: -8,
              child: Image.asset(
                'assets/images/product_1.png',
                width: 190,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 150,
              bottom: -6,
              child: Image.asset(
                'assets/images/product_4.png',
                width: 140,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
