import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/shared/custom_text.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? profilePictureUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(3.r),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 45.r,
            backgroundColor: const Color(0xFF1A1730),
            child: ClipOval(
              child: profilePictureUrl != null && profilePictureUrl!.isNotEmpty
                  ? Image.network(
                      profilePictureUrl!,
                      width: 90.r,
                      height: 90.r,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _defaultAvatar(),
                    )
                  : _defaultAvatar(),
            ),
          ),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
                size: 20.sp,
                color: Colors.black87,
                weight: FontWeight.bold,
              ),
              Gap(4.h),
              CustomText(text: email, size: 13.sp, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }

  Widget _defaultAvatar() => Image.asset(
    "assets/default_profile_img.jpg",
    width: 90.r,
    height: 90.r,
    fit: BoxFit.cover,
  );
}
