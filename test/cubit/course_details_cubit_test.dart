import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_cubit.dart';
import 'package:mini_course_player/core/features/course_details_screen/cubit/course_details_state.dart';
import 'package:mini_course_player/core/features/course_details_screen/repo/course_details_repo.dart';

class MockCourseDetailsRepo extends Mock implements CourseDetailsRepo {}

void main() {
  late CourseDetailsCubit cubit;
  late MockCourseDetailsRepo mockRepo;

  setUp(() {
    mockRepo = MockCourseDetailsRepo();
    cubit = CourseDetailsCubit(mockRepo);
  });

  blocTest<CourseDetailsCubit, CourseDetailsState>(
    'emits [Loading, Loaded] when loadLastPosition succeeds',
    build: () {
      when(() => mockRepo.getLastPosition('c001')).thenAnswer((_) async => 15);

      return cubit;
    },
    act: (cubit) => cubit.loadLastPosition('c001'),
    expect: () => [isA<CourseDetailsLoading>(), isA<CourseDetailsLoaded>()],
    verify: (_) {
      verify(() => mockRepo.getLastPosition('c001')).called(1);
    },
  );
  blocTest<CourseDetailsCubit, CourseDetailsState>(
    'emits [Loading, Error] when loadLastPosition fails',
    build: () {
      when(
        () => mockRepo.getLastPosition('c001'),
      ).thenThrow(Exception('Failed to load position'));

      return cubit;
    },
    act: (cubit) => cubit.loadLastPosition('c001'),
    expect: () => [isA<CourseDetailsLoading>(), isA<CourseDetailsError>()],
  );
}
