import 'package:chiclet/chiclet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../shared.dart';
import 'package:flutter/material.dart';

class AppButton extends HookWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final Color? hoverColor;
  final bool isLoading;
  final double? fontSize, height, width, buttonHeight;
  final BorderRadius? borderRadius;
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.hoverColor,
    this.isLoading = false,
    this.borderRadius,
    this.fontSize,
    this.height,
    this.width = double.infinity,
    this.buttonHeight,
  });

  factory AppButton.small({
    required String title,
    required VoidCallback? onTap,
    Color? color,
    Color? hoverColor,
    bool isLoading = false,
    double? fontSize,
    double? height,
    double? width,
    BorderRadius? borderRadius,
  }) {
    return AppButton(
      title: title,
      onTap: onTap,
      color: color,
      hoverColor: hoverColor,
      isLoading: isLoading,
      fontSize: fontSize ?? 16,
      height: height ?? 44,
      width: width,
      buttonHeight: 4,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final buttonColor = useState<Color>(color ?? appColors.lightBlue);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) =>
          buttonColor.value = (hoverColor ?? appColors.lightBlueHover),
      onExit: (_) => buttonColor.value = (color ?? appColors.lightBlue),
      child: ChicletAnimatedButton(
          width: width,
          height: height ?? 57,
          onPressed: onTap,
          buttonHeight: buttonHeight ?? 5,
          backgroundColor: buttonColor.value,
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize ?? 19,
              letterSpacing: 1.2,
              color: theme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}

class AppIconButton extends HookWidget {
  final dynamic icon;
  final VoidCallback? onTap;
  final Color? color;
  final Color? hoverColor;
  final double? height, width;
  final BorderRadius? borderRadius;
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
    this.hoverColor,
    this.borderRadius,
    this.height,
    this.width,
  }) : assert(
          icon is String || icon is IconData,
          'The icon must be of type String or IconData',
        );

  @override
  Widget build(BuildContext context) {
    final buttonColor = useState<Color>(color ?? appColors.lightBlue);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) =>
          buttonColor.value = (hoverColor ?? appColors.lightBlueHover),
      onExit: (_) => buttonColor.value = (color ?? appColors.lightBlue),
      child: ChicletAnimatedButton(
        width: width != null ? (width! + 5) : width,
        height: height ?? 40,
        onPressed: onTap,
        borderRadius: 8,
        buttonHeight: 5,
        backgroundColor: buttonColor.value,
        child: icon is String
            ? SvgAsset(path: icon)
            : Icon(icon, color: appColors.darkNavy, size: 25),
      ),
    );
  }
}


/*
class AppButton extends HookWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final Color? hoverColor;
  final bool isLoading;
  final TextStyle? textStyle;
  final BorderRadius? borderRadius;
  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.hoverColor,
    this.isLoading = false,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final buttonColor = useState<Color>(color ?? appColors.lightBlue);
    final shadowColor =
        useState<Color>((color ?? appColors.lightBlue).withOpacity(.5));
    final shadowVisible = useState<bool>(true);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) =>
          buttonColor.value = (hoverColor ?? appColors.lightBlueHover),
      onExit: (_) => buttonColor.value = (color ?? appColors.lightBlue),
      child: GestureDetector(
        onTapDown: (_) {
          shadowVisible.value = false;
        },
        onTapUp: (_) {
          shadowVisible.value = true;
          if (onTap != null) onTap!();
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            // width: double.infinity,
            height: 64,
            margin: EdgeInsets.only(bottom: shadowVisible.value ? 4 : 0),
            decoration: BoxDecoration(
              color: buttonColor.value,
              borderRadius: borderRadius ?? BorderRadius.circular(15),
              boxShadow: shadowVisible.value
                  ? [
                      BoxShadow(
                        color: shadowColor.value,
                        offset: Offset(0, 6),
                        blurRadius: 0, // No blur
                      )
                    ]
                  : null,
            ),
            child: isLoading
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: theme.surface,
                  )
                : Text(
                    title,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 20,
                          color: theme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
*/