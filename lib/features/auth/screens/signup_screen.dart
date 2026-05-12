import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/core/network/api_error.dart';
import 'package:posts_app/core/utils/validators.dart';
import 'package:posts_app/features/auth/data/auth_repo.dart';
import 'package:posts_app/features/auth/screens/login_screen.dart';
import 'package:posts_app/features/auth/widgets/auth_card.dart';
import 'package:posts_app/features/auth/widgets/auth_header.dart';
import 'package:posts_app/features/auth/widgets/custom_auth_btn.dart';
import 'package:posts_app/root.dart';
import 'package:posts_app/shared/custom_snack_bar.dart';
import 'package:posts_app/shared/custom_text.dart';
import 'package:posts_app/shared/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passController.text.trim(),
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
        String errorMsg = 'Unhandled Signup Error';
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
                          text: 'Sign Up',
                          color: AppColors.primary,
                          size: 26.sp,
                          weight: FontWeight.w700,
                        ),
                        Gap(20.h),
                        CustomTextField(
                          hint: 'Name',
                          isPassword: false,
                          validator: AppValidators.validateName,
                          controller: nameController,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                        ),
                        Gap(14.h),
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
                          controller: passController,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),
                        ),
                        Gap(24.h),
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              )
                            : CustomAuthBtn(
                                text: 'Create Account',
                                textColor: Colors.white,
                                color: AppColors.primary,
                                // onTap: signup,
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
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: 'Already have an account? Login',
                              color: AppColors.primary,
                              size: 13.sp,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
