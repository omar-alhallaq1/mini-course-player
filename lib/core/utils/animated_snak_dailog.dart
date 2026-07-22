import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

dynamic showAnimatedSnakDailog(
  BuildContext context, {
  String? message,
  AnimatedSnackBarType? type,
}) {
  AnimatedSnackBar.material(
    message ?? "",
    type: type ?? AnimatedSnackBarType.success,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.bottomRight,
  ).show(context);
}
