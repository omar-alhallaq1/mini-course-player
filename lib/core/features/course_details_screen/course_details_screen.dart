import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_details_screen/widgets/course_details_widget.dart';
import 'package:mini_course_player/core/wedgets/custom_back_button_widget.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. قسم الـ Header العلوي (داخل Padding ليحتفظ بالمسافة)
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

              // 2. تفاصيل الكورس والفيديو (بدون Padding خارجي ليمتد الفيديو بكامل عرض الشاشة)
              CourseDetailsSection(
                videoUrl:
                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                title: 'Advanced Flutter Development',
                description:
                    "Deep dive into state management, custom "
                    "animations and native integrations. Learn "
                    "professional patterns used by top-tier mobile "
                    "engineering teams",
                durationSeconds: 20,
                progress: 0.40, // 👈 تعديل القيمة إلى 0.40 لتكون 40%
              ),
            ],
          ),
        ),
      ),
    );
  }
}
