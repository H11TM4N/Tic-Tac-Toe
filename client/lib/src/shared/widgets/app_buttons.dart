import 'package:flutter_hooks/flutter_hooks.dart';
import '../shared.dart';
import 'package:flutter/material.dart';

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
            height: shadowVisible.value ? 64 : 67,
            margin: EdgeInsets.only(top: shadowVisible.value ? 4 : 0),
            decoration: BoxDecoration(
              color: buttonColor.value,
              borderRadius: borderRadius ?? BorderRadius.circular(15),
              boxShadow: shadowVisible.value
                  ? [
                      BoxShadow(
                        color: shadowColor.value,
                        offset: Offset(0, 8),
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
