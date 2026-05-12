import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/shared/custom_text.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Icon(
            Icons.article_outlined,
            color: AppColors.primary,
            size: 50.sp,
          ),
        ),
        Gap(8.h),
        CustomText(
          text: 'Posts App',
          color: AppColors.primary,
          size: 25.sp,
          weight: FontWeight.w600,
        ),
      ],
    );
  }
}
