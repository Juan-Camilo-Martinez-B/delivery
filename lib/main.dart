import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/food_provider.dart';
import 'presentation/pages/splash_screen.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
      ],
      child: const FoodgoApp(),
    ),
  );
}

class FoodgoApp extends StatelessWidget {
  const FoodgoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodgo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
