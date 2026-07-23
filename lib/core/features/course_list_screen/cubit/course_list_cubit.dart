import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_state.dart';
import 'package:mini_course_player/core/features/course_list_screen/repo/course_list_repo.dart';

class CourseListCubit extends Cubit<CourseListState> {
  CourseListCubit(this._courseRepo, this._detailsRepo)
    : super(CourseListInitial());

  final CourseRepo _courseRepo;
  final CourseDetailsRepo _detailsRepo;

  Future<void> fetchCourses() async {
    emit(CourseListLoading());

    final res = await _courseRepo.getCourses();

    res.fold(
      (error) {
        emit(CourseListError(error));
      },
      (courses) async {
        final progressMap = <String, double>{};

        for (final course in courses) {
          final savedPosition = await _detailsRepo.getLastPosition(course.id);

          final progress = course.durationSeconds == 0
              ? 0.0
              : (savedPosition / course.durationSeconds).clamp(0.0, 1.0);

          progressMap[course.id] = progress;
        }

        emit(CourseListSuccess(courses: courses, progressMap: progressMap));
      },
    );
  }
}
