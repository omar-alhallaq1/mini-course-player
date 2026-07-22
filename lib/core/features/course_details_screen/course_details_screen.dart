import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_cubit.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_state.dart';
import 'package:mini_course_player/core/features/course_details_screen/widgets/course_details_widget.dart';
import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';
import 'package:mini_course_player/core/utils/animated_snak_dailog.dart';
import 'package:mini_course_player/core/wedgets/custom_back_button_widget.dart';
import 'package:mini_course_player/core/wedgets/error_state_widget.dart';
import 'package:mini_course_player/core/wedgets/loding_widget.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseDetailsScreen extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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

            Expanded(
              child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
                listener: (context, state) {
                  if (state is CourseDetailsError) {
                    showAnimatedSnakDailog(
                      context,
                      message: "Something went wrong",
                      type: AnimatedSnackBarType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CourseDetailsLoading) {
                    return const Center(child: LodingWidget());
                  }

                  if (state is CourseDetailsError) {
                    return ErrorStateWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<CourseDetailsCubit>().loadLastPosition(
                          course.id,
                        );
                      },
                    );
                  }

                  if (state is CourseDetailsLoaded) {
                    final progress = course.durationSeconds > 0
                        ? (state.lastPosition / course.durationSeconds).clamp(
                            0.0,
                            1.0,
                          )
                        : 0.0;

                    return SingleChildScrollView(
                      child: CourseDetailsSection(
                        videoUrl: course.videoUrl,
                        title: course.title,
                        description: course.description,
                        durationSeconds: course.durationSeconds,
                        progress: progress,
                        lastPosition: state.lastPosition,
                        onPositionChanged: (position) {
                          context.read<CourseDetailsCubit>().saveLastPosition(
                            courseId: course.id,
                            position: position,
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
