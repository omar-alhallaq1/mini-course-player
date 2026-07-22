import 'package:shared_preferences/shared_preferences.dart';

class CourseDetailsRepo {
  final SharedPreferences prefs;

  CourseDetailsRepo(this.prefs);

  Future<void> saveLastPosition({
    required String courseId,
    required int position,
  }) async {
    await prefs.setInt('course_position_$courseId', position);
  }

  Future<int> getLastPosition(String courseId) async {
    return prefs.getInt('course_position_$courseId') ?? 0;
  }
}
