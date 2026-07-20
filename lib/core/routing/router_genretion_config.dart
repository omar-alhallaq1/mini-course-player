import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_course_player/core/routing/app_routes.dart';

class RouterGanretionConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.onboardingScreen,
    routes: [
      GoRoute(
        name: AppRoutes.onboardingScreen,
        path: AppRoutes.onboardingScreen,

        builder: (context, state) => Container(),
      ),
    ],
  );
}
