import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/core/network/api_error.dart';
import 'package:posts_app/core/utils/validators.dart';
import 'package:posts_app/features/auth/data/auth_repo.dart';
import 'package:posts_app/features/auth/screens/signup_screen.dart';
import 'package:posts_app/features/auth/widgets/auth_card.dart';
import 'package:posts_app/features/auth/widgets/auth_header.dart';
import 'package:posts_app/features/auth/widgets/custom_auth_btn.dart';
import 'package:posts_app/root.dart';
import 'package:posts_app/shared/custom_snack_bar.dart';
import 'package:posts_app/shared/custom_text.dart';
import 'package:posts_app/shared/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Root()),
            (route) => false,
          );
        }
      } catch (e) {
        setState(() => isLoading = false);
        String errorMsg = 'Unhandled Login Error';
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(errorMsg));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthHeader(),
                  Gap(28.h),
                  AuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Login',
                          color: AppColors.primary,
                          size: 26.sp,
                          weight: FontWeight.w700,
                        ),
                        Gap(20.h),
                        CustomTextField(
                          hint: 'Email Address',
                          isPassword: false,
                          validator: AppValidators.validateEmail,
                          controller: emailController,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                        ),
                        Gap(14.h),
                        CustomTextField(
                          hint: 'Password',
                          isPassword: true,
                          validator: AppValidators.validatePassword,
                          controller: passwordController,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                        ),
                        Gap(8.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: CustomText(
                              text: 'Forgot password?',
                              color: AppColors.primary,
                              size: 12.sp,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Gap(20.h),

                        if (isLoading)
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        else
                          CustomAuthBtn(
                            text: 'Login',
                            textColor: Colors.white,
                            color: AppColors.primary,
                            // onTap: login,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Root(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                          ),
                        Gap(14.h),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: "Don't have an account? Sign Up",
                              color: AppColors.primary,
                              size: 13.sp,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
