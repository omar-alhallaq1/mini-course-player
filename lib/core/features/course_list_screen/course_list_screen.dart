import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_state.dart';
import 'package:mini_course_player/core/features/course_list_screen/widgets/course_card_widget.dart';
import 'package:mini_course_player/core/routing/app_routes.dart';
import 'package:mini_course_player/core/utils/animated_snak_dailog.dart';
import 'package:mini_course_player/core/wedgets/error_state_widget.dart';
import 'package:mini_course_player/core/wedgets/loding_widget.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CourseListCubit, CourseListState>(
        listener: (context, state) {
          if (state is CourseListError) {
            showAnimatedSnakDailog(
              context,
              message: "Something went wrong",
              type: AnimatedSnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is CourseListLoading) {
            return const Center(child: LodingWidget());
          }

          if (state is CourseListError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () {
                context.read<CourseListCubit>().fetchCourses();
              },
            );
          }

          if (state is CourseListSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).r,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(56.h),

                    Text("My Courses", style: AppStyles.primaryheadlinestyle),

                    Gap(8.h),

                    Text(
                      "Continue learning where you left off.",
                      style: AppStyles.secondaryheadlinestyle,
                    ),

                    Gap(24.h),

                    ...state.courses.map(
                      (course) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CustomCourseCard(
                          imageUrl: course.thumbnailUrl,
                          title: course.title,
                          duration: "${course.durationSeconds}s duration",
                          description: course.description,
                          progressText: "0% Completed",
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRoutes.courseDetailsScreen,
                              extra: course,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
