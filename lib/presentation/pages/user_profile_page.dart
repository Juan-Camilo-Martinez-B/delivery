import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: AppTextStyles.subtitle),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/icons/arrow_left.png', width: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.lightGray,
                    child: Icon(Icons.person, size: 80, color: AppColors.textSecondary),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/icons/edit.png', width: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text("John Doe", style: AppTextStyles.title),
            Text("johndoe@example.com", style: AppTextStyles.body),
            const SizedBox(height: 40),
            _buildProfileItem(
              icon: 'assets/icons/settings.png',
              label: "Settings",
              onTap: () {},
            ),
            _buildProfileItem(
              icon: 'assets/icons/lock.png',
              label: "Change Password",
              onTap: () {},
            ),
            _buildProfileItem(
              icon: 'assets/icons/sign_out.png',
              label: "Log Out",
              onTap: () {},
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required String icon, required String label, required VoidCallback onTap, Color? color}) {
    return ListTile(
      leading: Image.asset(icon, width: 24, color: color ?? AppColors.textPrimary),
      title: Text(label, style: AppTextStyles.body.copyWith(color: color ?? AppColors.textPrimary, fontWeight: FontWeight.w600)),
      trailing: Image.asset('assets/icons/angle_right.png', width: 16),
      onTap: onTap,
    );
  }
}
