import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';

abstract class CourseListState {}

class CourseListInitial extends CourseListState {}

class CourseListLoading extends CourseListState {}

class CourseListSuccess extends CourseListState {
  final List<CourseModel> courses;
  final Map<String, double> progressMap;

  CourseListSuccess({required this.courses, this.progressMap = const {}});
}

class CourseListError extends CourseListState {
  final String message;

  CourseListError(this.message);
}
