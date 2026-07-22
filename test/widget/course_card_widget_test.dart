import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_course_player/core/features/course_list_screen/widgets/course_card_widget.dart';

void main() {
  testWidgets(
    'CustomCourseCard displays course information and responds to tap',
    (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(393, 852),
          child: MaterialApp(
            home: Scaffold(
              body: CustomCourseCard(
                imageUrl: 'https://picsum.photos/200',
                title: 'Flutter Course',
                duration: '30 min',
                description: 'Learn Flutter from scratch',
                progressText: '50%',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Flutter Course'), findsOneWidget);

      expect(find.text('30 min'), findsOneWidget);

      expect(find.text('Learn Flutter from scratch'), findsOneWidget);

      await tester.tap(find.byType(InkWell));

      expect(tapped, isTrue);
    },
  );
}
