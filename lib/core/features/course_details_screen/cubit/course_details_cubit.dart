import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_state.dart';
import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit(this._repo) : super(CourseDetailsInitial());

  final CourseDetailsRepo _repo;

  Future<void> loadLastPosition(String courseId) async {
    emit(CourseDetailsLoading());

    try {
      final position = await _repo.getLastPosition(courseId);

      emit(CourseDetailsLoaded(position));
    } catch (e) {
      emit(CourseDetailsError(e.toString()));
    }
  }

  Future<void> saveLastPosition({
    required String courseId,
    required int position,
  }) async {
    await _repo.saveLastPosition(courseId: courseId, position: position);
  }
}
