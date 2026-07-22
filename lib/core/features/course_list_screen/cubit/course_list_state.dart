import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';

abstract class CourseListState {}

class CourseListInitial extends CourseListState {}

class CourseListLoading extends CourseListState {}

class CourseListSuccess extends CourseListState {
  final List<CourseModel> courses;

  CourseListSuccess(this.courses);
}

class CourseListError extends CourseListState {
  final String message;

  CourseListError(this.message);
}
