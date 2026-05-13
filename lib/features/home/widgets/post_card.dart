import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:posts_app/features/home/data/post_model.dart';
import 'package:posts_app/shared/custom_text.dart';

class PostCard extends StatefulWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  late int likesCount;

  @override
  void initState() {
    super.initState();
    likesCount = widget.post.likes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likesCount = isLiked ? likesCount + 1 : likesCount - 1;
    });
  }

  Color _avatarColor() {
    final colors = [
      const Color(0xFFEEEDFE),
      const Color(0xFFE1F5EE),
      const Color(0xFFFAECE7),
      const Color(0xFFFBEAF0),
      const Color(0xFFE6F1FB),
    ];
    return colors[(widget.post.userId - 1) % colors.length];
  }

  Color _avatarTextColor() {
    final colors = [
      const Color(0xFF3C3489),
      const Color(0xFF085041),
      const Color(0xFF712B13),
      const Color(0xFF72243E),
      const Color(0xFF0C447C),
    ];
    return colors[(widget.post.userId - 1) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.black.withOpacity(0.08), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 17.r,
                backgroundColor: _avatarColor(),
                child: CustomText(
                  text: 'U${widget.post.userId}',
                  size: 11.sp,
                  color: _avatarTextColor(),
                  weight: FontWeight.w600,
                ),
              ),
              Gap(10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'User ${widget.post.userId}',
                    size: 12.sp,
                    color: Colors.black54,
                    weight: FontWeight.w500,
                  ),
                  CustomText(
                    text: '#${widget.post.id}',
                    size: 11.sp,
                    color: Colors.black38,
                  ),
                ],
              ),
            ],
          ),
          Gap(10.h),
          CustomText(
            text: widget.post.title,
            size: 14.sp,
            color: Colors.black87,
            weight: FontWeight.w600,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(6.h),
          CustomText(
            text: widget.post.body.replaceAll('\n', ' '),
            size: 12.sp,
            color: Colors.black54,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.post.tags
                  .map(
                    (tag) => Container(
                      margin: EdgeInsets.only(right: 6.w),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: _avatarColor(),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: CustomText(
                        text: tag,
                        size: 10.sp,
                        color: _avatarTextColor(),
                        weight: FontWeight.w500,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Gap(10.h),
          Divider(height: 1, color: Colors.black.withOpacity(0.06)),
          Gap(8.h),
          Row(
            children: [
              GestureDetector(
                onTap: _toggleLike,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isLiked),
                    size: 17.sp,
                    color: isLiked ? Colors.redAccent : Colors.black38,
                  ),
                ),
              ),
              Gap(4.w),
              CustomText(
                text: '$likesCount',
                size: 12.sp,
                color: isLiked ? Colors.redAccent : Colors.black38,
              ),
              Gap(14.w),
              _ActionBtn(
                icon: Icons.remove_red_eye_outlined,
                label: '${widget.post.views}',
              ),
              const Spacer(),
              _ActionBtn(icon: Icons.share_outlined),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String? label;

  const _ActionBtn({required this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17.sp, color: Colors.black38),
        if (label != null) ...[
          Gap(3.w),
          CustomText(text: label!, size: 12.sp, color: Colors.black38),
        ],
      ],
    );
  }
}
