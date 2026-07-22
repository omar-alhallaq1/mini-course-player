import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';

class CourseRepo {
  Future<Either<String, List<CourseModel>>> getCourses() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/courses.json',
      );

      final Map<String, dynamic> responseData = jsonDecode(jsonString);

      List<CourseModel> courses = (responseData['courses'] as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();

      return Right(courses);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
