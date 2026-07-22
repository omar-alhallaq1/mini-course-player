import 'package:get_it/get_it.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_cubit.dart';
import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/repo/course_list_repo.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  // Repository
  sl.registerLazySingleton(() => CourseRepo());

  // Cubit
  sl.registerFactory(() => CourseListCubit(sl<CourseRepo>()));
  sl.registerFactory(() => CourseDetailsCubit(sl<CourseDetailsRepo>()));

  sl.registerLazySingleton(() => CourseDetailsRepo());
}
