import 'package:flutter/material.dart';

class CustomBackButtonWidget extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const CustomBackButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.maybePop(context),
      borderRadius: BorderRadius.circular(45),
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F6F9), // الخلفية من صورة image_7e099e.png
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon, // عرض الـ SVG مباشرة في المنتصف
        ),
      ),
    );
  }
}
