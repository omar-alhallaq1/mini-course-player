import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_cubit.dart';
import 'package:mini_course_player/core/features/course_list_screen/cubit/course_list_state.dart';
import 'package:mini_course_player/core/features/course_list_screen/model/course_model.dart';
import 'package:mini_course_player/core/features/course_list_screen/repo/course_list_repo.dart';

class MockCourseRepo extends Mock implements CourseRepo {}

class MockCourseDetailsRepo extends Mock implements CourseDetailsRepo {}

void main() {
  late CourseListCubit courseListCubit;
  late MockCourseRepo mockCourseRepo;
  late MockCourseDetailsRepo mockCourseDetailsRepo;

  final tCourses = [
    const CourseModel(
      id: 'c001',
      title: 'Intro to Flutter',
      thumbnailUrl: 'https://example.com/thumb.png',
      durationSeconds: 100,
      description: 'Test Description',
      videoUrl: 'https://example.com/video.mp4',
    ),
  ];

  setUp(() {
    mockCourseRepo = MockCourseRepo();
    mockCourseDetailsRepo = MockCourseDetailsRepo();
    courseListCubit = CourseListCubit(mockCourseRepo, mockCourseDetailsRepo);
  });

  tearDown(() {
    courseListCubit.close();
  });

  group('CourseListCubit Tests', () {
    test('initial state should be CourseListInitial', () {
      expect(courseListCubit.state, isA<CourseListInitial>());
    });

    blocTest<CourseListCubit, CourseListState>(
      'emits [CourseListLoading, CourseListSuccess] with correct progress ratio when fetching courses succeeds',
      build: () {
        when(
          () => mockCourseRepo.getCourses(),
        ).thenAnswer((_) async => Right(tCourses));

        when(
          () => mockCourseDetailsRepo.getLastPosition('c001'),
        ).thenAnswer((_) async => 50);

        return courseListCubit;
      },
      act: (cubit) => cubit.fetchCourses(),
      expect: () => [
        isA<CourseListLoading>(),
        isA<CourseListSuccess>().having(
          (s) => s.progressMap['c001'],
          'progressMap for c001',
          0.5,
        ),
      ],
      verify: (_) {
        verify(() => mockCourseRepo.getCourses()).called(1);
        verify(() => mockCourseDetailsRepo.getLastPosition('c001')).called(1);
      },
    );

    blocTest<CourseListCubit, CourseListState>(
      'emits [CourseListLoading, CourseListError] when fetching courses fails',
      build: () {
        when(
          () => mockCourseRepo.getCourses(),
        ).thenAnswer((_) async => const Left('Failed to load courses'));
        return courseListCubit;
      },
      act: (cubit) => cubit.fetchCourses(),
      expect: () => [
        isA<CourseListLoading>(),
        isA<CourseListError>().having(
          (s) => s.message,
          'error message',
          'Failed to load courses',
        ),
      ],
    );
  });
}
