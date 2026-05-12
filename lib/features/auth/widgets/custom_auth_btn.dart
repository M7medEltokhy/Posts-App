import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/shared/custom_text.dart';

class CustomAuthBtn extends StatelessWidget {
  const CustomAuthBtn({
    super.key,
    this.onTap,
    required this.text,
    this.color,
    this.textColor,
    this.width,
  });

  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: color ?? Colors.white,
          border: Border.all(color: Colors.white60.withOpacity(0.5),width: 2),
        ),
        child: Center(
          child: CustomText(
            text: text,
            size: 18.sp,
            color: textColor ?? AppColors.primary,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
