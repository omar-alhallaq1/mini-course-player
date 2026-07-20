import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mini_course_player/styling/app_colors.dart';

class PrimaryButtonwidget extends StatelessWidget {
  final String? buttontext;
  final Color? buttoncolor;
  final double? width;
  final double? height;
  final double? borderradius;
  final Color? textColor;
  final double? fontsize;
  final Widget? icon;
  final Widget? trailingicon;
  final void Function()? onpress;
  final bool isloading;

  const PrimaryButtonwidget({
    super.key,
    this.buttontext,
    this.buttoncolor,
    this.width,
    this.height,
    this.borderradius,
    this.textColor,
    this.onpress,
    this.fontsize,
    this.icon,
    this.trailingicon,
    this.isloading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttoncolor ?? AppColors.primarycolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderradius ?? 8.r),
        ),
        fixedSize: Size(width ?? 342.w, height ?? 56.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? icon! : SizedBox.shrink(),
          icon != null ? Gap(8.w) : SizedBox.shrink(),
          isloading
              ? SizedBox(
                  height: 30.sp,
                  width: 30.sp,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                )
              : SizedBox.shrink(),

          Text(
            buttontext ?? "Button",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: textColor ?? Colors.white,
              fontSize: fontsize ?? 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailingicon != null ? Gap(8.w) : SizedBox.shrink(),
          trailingicon != null ? trailingicon! : SizedBox.shrink(),
        ],
      ),
    );
  }
}
