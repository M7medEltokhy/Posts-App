import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/core/utils/pref_helpers.dart';
import 'package:posts_app/features/auth/screens/login_screen.dart';
import 'package:posts_app/features/auth/widgets/build_setting_items.dart';
import 'package:posts_app/features/auth/widgets/profile_header.dart';
import 'package:posts_app/shared/custom_button.dart';
import 'package:posts_app/shared/custom_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(32.h),
              const ProfileHeader(
                name: 'Mohamed Ali',
                email: 'Mohamed@example.com',
              ),
              Gap(24.h),
              CustomButton(
                onTap: () {},
                title: 'Edit Profile',
                height: 50,
                width: double.infinity,
                border: 14,
                color: AppColors.primary,
              ),
              Gap(32.h),
              CustomText(
                text: 'settings'.toUpperCase(),
                size: 12.sp,
                color: AppColors.primary,
                weight: FontWeight.w600,
              ),
              Gap(10.h),
              Column(
                children: [
                  BuildSettingsItem(
                    icon: Icons.language,
                    title: 'Language',
                    onTap: () {},
                  ),
                  BuildSettingsItem(
                    icon: Icons.info_outline,
                    title: 'About App',
                    onTap: () {},
                  ),
                  BuildSettingsItem(
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    onTap: () {},
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.shade400,
                height: 20.h,
                thickness: 0.5,
              ),
              BuildSettingsItem(
                icon: Icons.logout,
                title: 'Logout',
                isLogout: true,
                onTap: () {
                  PrefHelper.removeToken();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
              Gap(250.h),
            ],
          ),
        ),
      ),
    );
  }
}
