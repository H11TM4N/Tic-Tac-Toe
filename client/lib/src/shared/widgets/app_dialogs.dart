import '../shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static void dialog(
    Widget content, {
    Color? bgColor,
    bool dismissable = true,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        insetPadding: EdgeInsets.zero,
        backgroundColor: bgColor ?? appColors.semiDarkNavy,
        shadowColor: bgColor ?? appColors.semiDarkNavy,
        child: content,
      ),
      barrierDismissible: dismissable,
    );
  }
}
