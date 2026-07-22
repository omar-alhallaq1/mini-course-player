import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_course_player/styling/app_assets.dart';

class LodingWidget extends StatelessWidget {
  final double? width;
  final double? height;
  const LodingWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 25.w,
      height: height ?? 25.h,
      child: Center(
        child: LottieBuilder.asset(
          AppAssets.lottieLoading,
          width: 150.sp,
          height: 150.sp,
        ),
      ),
    );
  }
}
