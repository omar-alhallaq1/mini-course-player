import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/features/course_details_screen/course_details_screen.dart';
import 'package:mini_course_player/core/features/course_list_screen/course_list_screen.dart';
import 'package:mini_course_player/core/routing/app_routes.dart';

class RouterGanretionConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.courseListScreen,
    routes: [
      GoRoute(
        name: AppRoutes.courseListScreen,
        path: AppRoutes.courseListScreen,

        builder: (context, state) => const CourseListScreen(),
      ),
      GoRoute(
        name: AppRoutes.courseDetailsScreen,
        path: AppRoutes.courseDetailsScreen,

        builder: (context, state) => const CourseDetailsScreen(),
      ),
    ],
  );
}
