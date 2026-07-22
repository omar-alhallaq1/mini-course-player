import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mini_course_player/core/features/course_details_screen/widgets/video_player_widget.dart';
import 'package:mini_course_player/styling/app_colors.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseDetailsSection extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String description;
  final int durationSeconds;
  final double progress;

  const CourseDetailsSection({
    super.key,
    required this.videoUrl,
    required this.title,
    required this.description,
    required this.durationSeconds,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CourseVideoPlayer(videoUrl: videoUrl),

        Gap(24.h),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.primaryheadlinestyle.copyWith(fontSize: 22.sp),
              ),

              Gap(12),

              Text(
                description,
                style: AppStyles.secondaryheadlinestyle.copyWith(
                  fontSize: 16.sp,
                ),
              ),

              Gap(32.h),

              Row(
                children: [
                  Icon(Icons.access_time_rounded, color: Color(0xFF4338CA)),
                  Gap(8.w),
                  Text(
                    _formatDuration(durationSeconds),
                    style: AppStyles.black16w500style,
                  ),
                ],
              ),

              Gap(30.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Course Progress", style: AppStyles.black16w500style),
                  Text(
                    "$percentage%",
                    style: AppStyles.primary12meduemstyle.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),

              Gap(8.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.whitecolor,
                  color: AppColors.primarycolor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _formatDuration(int seconds) {
  if (seconds < 60) {
    return '${seconds}s Total Duration';
  }

  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;

  if (remainingSeconds == 0) {
    return '${minutes}m Total Duration';
  }

  return '${minutes}m ${remainingSeconds}s Total Duration';
}
