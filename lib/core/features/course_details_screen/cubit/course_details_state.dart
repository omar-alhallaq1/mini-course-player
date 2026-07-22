abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final int lastPosition;

  CourseDetailsLoaded(this.lastPosition);
}

class CourseDetailsError extends CourseDetailsState {
  final String message;

  CourseDetailsError(this.message);
}
