import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButtonWidget extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const CustomBackButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.maybePop(context),
      customBorder: const CircleBorder(),
      child: Container(
        width: 20.r,
        height: 20.r,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
