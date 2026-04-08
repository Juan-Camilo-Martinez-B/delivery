import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle logo = GoogleFonts.lobster(
    fontSize: 32,
    color: AppColors.primary,
  );
}
