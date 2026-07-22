import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_details_screen/course_details_screen.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/course_list_screen.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';
import 'package:mini_course_player/core/routing/app_routes.dart';
import 'package:mini_course_player/core/utils/service_locator.dart';

class RouterGanretionConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.courseListScreen,
    routes: [
      GoRoute(
        name: AppRoutes.courseListScreen,
        path: AppRoutes.courseListScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<CourseListCubit>()..fetchCourses(),
          child: const CourseListScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.courseDetailsScreen,
        name: AppRoutes.courseDetailsScreen,
        builder: (context, state) {
          final course = state.extra as CourseModel;

          return BlocProvider(
            create: (_) =>
                sl<CourseDetailsCubit>()..loadLastPosition(course.id),
            child: CourseDetailsScreen(course: course),
          );
        },
      ),
    ],
  );
}
