import 'package:get_it/get_it.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_cubit.dart';
import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/repo/course_list_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  // Repository
  sl.registerLazySingleton(() => CourseRepo());
  sl.registerLazySingleton(() => CourseDetailsRepo(sl<SharedPreferences>()));

  // Cubit
  sl.registerFactory(
    () => CourseListCubit(sl<CourseRepo>(), sl<CourseDetailsRepo>()),
  );
  sl.registerFactory(() => CourseDetailsCubit(sl<CourseDetailsRepo>()));
}
