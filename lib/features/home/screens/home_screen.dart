import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/core/constants/app_colors.dart';
import 'package:posts_app/features/home/cubit/posts_cubit.dart';
import 'package:posts_app/features/home/cubit/posts_state.dart';
import 'package:posts_app/features/home/data/posts_repo.dart';
import 'package:posts_app/features/home/widgets/post_card.dart';
import 'package:posts_app/shared/custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(PostsRepo())..getPosts(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Posts',
                      size: 22.sp,
                      weight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    Icon(Icons.search, size: 22.sp, color: Colors.black54),
                  ],
                ),
              ),
              Gap(4.h),
              Expanded(
                child: BlocBuilder<PostsCubit, PostsState>(
                  builder: (context, state) {
                    if (state is PostsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    }

                    if (state is PostsFailure) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: Colors.redAccent,
                            ),
                            Gap(12.h),
                            CustomText(
                              text: state.error,
                              size: 14.sp,
                              color: Colors.redAccent,
                            ),
                            Gap(16.h),
                            TextButton(
                              onPressed: () =>
                                  context.read<PostsCubit>().getPosts(),
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is PostsSuccess) {
                      return RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () => context.read<PostsCubit>().getPosts(),
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          padding: EdgeInsets.only(bottom: 20.h),
                          itemBuilder: (context, index) =>
                              PostCard(post: state.posts[index]),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              Gap(50.h),
            ],
          ),
        ),
      ),
    );
  }
}
