import 'package:shared_preferences/shared_preferences.dart';

class CourseDetailsRepo {
  Future<void> saveLastPosition({
    required String courseId,
    required int position,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('course_position_$courseId', position);
  }

  Future<int> getLastPosition(String courseId) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('course_position_$courseId') ?? 0;
  }
}
