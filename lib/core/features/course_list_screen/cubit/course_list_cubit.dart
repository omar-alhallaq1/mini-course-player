import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_state.dart';
import 'package:mini_course_player/core/features/course_list_screen/repo/course_list_repo.dart';

class CourseListCubit extends Cubit<CourseListState> {
  CourseListCubit(this._courseRepo) : super(CourseListInitial());

  final CourseRepo _courseRepo;

  void fetchCourses() async {
    emit(CourseListLoading());

    final res = await _courseRepo.getCourses();

    res.fold(
      (error) {
        emit(CourseListError(error));
      },
      (courses) {
        emit(CourseListSuccess(courses));
      },
    );
  }
}
