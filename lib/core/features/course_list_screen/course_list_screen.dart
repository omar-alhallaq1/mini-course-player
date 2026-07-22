import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_list_screen/widgets/course_card_widget.dart';
import 'package:mini_course_player/core/routing/app_routes.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              CustomCourseCard(
                imageUrl:
                    'https://imgs.search.brave.com/LVlQEsGFJc_O4qB5SaSM-Sp-3md9wvq_33PWyz9ljCU/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9wbmcu/cG5ndHJlZS5jb20v/dGh1bWJfYmFjay9m/aDI2MC9iYWNrZ3Jv/dW5kLzIwMjQwNjEw/L3BuZ3RyZWUtY29t/cHV0ZXItb2YtYS1w/cm9ncmFtbWVyLXdp/dGgtbGluZXMtY29k/ZS1vZi1zb2Z0d2Fy/ZS1pbWFnZV8xNTc0/NjAwMy5qcGc',
                title: 'Introduction to Python',
                duration: '8h duration',
                description: 'Master the basics of Python...',
                progressText: '30% Completed',
                onTap: () {
                  GoRouter.of(context).push(AppRoutes.courseDetailsScreen);
                },
              ),
              CustomCourseCard(
                imageUrl:
                    'https://imgs.search.brave.com/LVlQEsGFJc_O4qB5SaSM-Sp-3md9wvq_33PWyz9ljCU/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9wbmcu/cG5ndHJlZS5jb20v/dGh1bWJfYmFjay9m/aDI2MC9iYWNrZ3Jv/dW5kLzIwMjQwNjEw/L3BuZ3RyZWUtY29t/cHV0ZXItb2YtYS1w/cm9ncmFtbWVyLXdp/dGgtbGluZXMtY29k/ZS1vZi1zb2Z0d2Fy/ZS1pbWFnZV8xNTc0/NjAwMy5qcGc',
                title: 'Introduction to Python',
                duration: '8h duration',
                description: 'Master the basics of Python...',
                progressText: '30% Completed',
                onTap: () {},
              ),
              CustomCourseCard(
                imageUrl:
                    'https://imgs.search.brave.com/LVlQEsGFJc_O4qB5SaSM-Sp-3md9wvq_33PWyz9ljCU/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9wbmcu/cG5ndHJlZS5jb20v/dGh1bWJfYmFjay9m/aDI2MC9iYWNrZ3Jv/dW5kLzIwMjQwNjEw/L3BuZ3RyZWUtY29t/cHV0ZXItb2YtYS1w/cm9ncmFtbWVyLXdp/dGgtbGluZXMtY29k/ZS1vZi1zb2Z0d2Fy/ZS1pbWFnZV8xNTc0/NjAwMy5qcGc',
                title: 'Introduction to Python',
                duration: '8h duration',
                description: 'Master the basics of Python...',
                progressText: '30% Completed',
                onTap: () {},
              ),
              CustomCourseCard(
                imageUrl:
                    'https://imgs.search.brave.com/LVlQEsGFJc_O4qB5SaSM-Sp-3md9wvq_33PWyz9ljCU/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9wbmcu/cG5ndHJlZS5jb20v/dGh1bWJfYmFjay9m/aDI2MC9iYWNrZ3Jv/dW5kLzIwMjQwNjEw/L3BuZ3RyZWUtY29t/cHV0ZXItb2YtYS1w/cm9ncmFtbWVyLXdp/dGgtbGluZXMtY29k/ZS1vZi1zb2Z0d2Fy/ZS1pbWFnZV8xNTc0/NjAwMy5qcGc',
                title: 'Introduction to Python',
                duration: '8h duration',
                description: 'Master the basics of Python...',
                progressText: '30% Completed',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
