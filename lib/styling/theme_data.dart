import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_course_player/styling/app_colors.dart';
import 'package:mini_course_player/styling/app_styles.dart';
class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primarycolor,
    scaffoldBackgroundColor: AppColors.whitecolor,

    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        titleLarge: AppStyles.primaryheadlinestyle,
        titleMedium: AppStyles.secondaryheadlinestyle,
      ),
    ),

    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primarycolor,
      disabledColor: AppColors.secondarycolor,
    ),
  );
}
