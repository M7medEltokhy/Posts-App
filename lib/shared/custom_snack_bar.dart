import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/shared/custom_text.dart';

SnackBar customSnackBar(String errorMsg,{Color? color}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    backgroundColor:color ?? Colors.red.shade900,
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white, size: 25.r),
        Gap(10.w),
        CustomText(
          text: errorMsg,
          color: Colors.white,
          size: 14.sp,
          weight: FontWeight.w500,
        ),
      ],
    ),
  );
}
