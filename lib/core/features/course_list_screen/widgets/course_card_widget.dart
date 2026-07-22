import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_course_player/styling/app_assets.dart';
import 'package:mini_course_player/styling/app_colors.dart';
import 'package:mini_course_player/styling/app_styles.dart';

class CustomCourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final String description;
  final String progressText;
  final VoidCallback? onTap;

  const CustomCourseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.description,
    required this.progressText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 206.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 206.h,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: Center(
                      child: SizedBox(
                        width: 50.r,
                        height: 50.r,
                        child: LottieBuilder.asset(
                          AppAssets.lottieLoading,
                          errorBuilder: (context, error, stackTrace) {
                            return const CircularProgressIndicator(
                              strokeWidth: 2,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 206.h,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.imagebrokensvg,
                        width: 40.r,
                        height: 40.r,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppStyles.primaryheadlinestyle.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                              Gap(6.h),
                              Text(
                                duration,
                                style: AppStyles.secondaryheadlinestyle
                                    .copyWith(fontSize: 12.sp),
                              ),
                              Gap(10.h),
                              Text(
                                description,
                                style: AppStyles.secondaryheadlinestyle
                                    .copyWith(fontSize: 14.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Gap(8.w),

                        SvgPicture.asset(
                          AppAssets.arrowright,
                          width: 24.r,
                          height: 24.r,
                          colorFilter: const ColorFilter.mode(
                            AppColors.blackcolor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
