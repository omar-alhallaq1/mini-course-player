import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_course_player/core/routing/router_genretion_config.dart';
import 'package:mini_course_player/core/utils/service_locator.dart';
import 'package:mini_course_player/styling/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppThemes.lightTheme,
          routerConfig: RouterGanretionConfig.goRouter,
        );
      },
    );
  }
}
