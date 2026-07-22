import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_details_screen/widgets/course_details_widget.dart';
import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';
import 'package:mini_course_player/core/wedgets/custom_back_button_widget.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                child: Row(
                  children: [
                    CustomBackButtonWidget(
                      icon: const Icon(Icons.arrow_back),
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                    ),
                    Gap(82.w),
                    Text(
                      "Course Details",
                      style: AppStyles.primaryheadlinestyle.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              CourseDetailsSection(
                videoUrl: course.videoUrl,
                title: course.title,
                description: course.description,
                durationSeconds: course.durationSeconds,
                progress: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
