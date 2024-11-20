import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class PlacementTile extends HookWidget {
  final String player1;
  final String display;
  final bool tileFilled;
  final VoidCallback onTap;
  const PlacementTile({
    super.key,
    required this.player1,
    required this.display,
    this.tileFilled = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHovering = useState<bool>(false);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => isHovering.value = true,
        onExit: (_) => isHovering.value = false,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tileFilled
                ? (display == 'x' ? appColors.lightBlue : appColors.lightYellow)
                : appColors.semiDarkNavy,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: tileFilled
                    ? (display == 'x'
                        ? appColors.lightBlue.withOpacity(.7)
                        : appColors.lightYellow.withOpacity(.7))
                    : appColors.shadow,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: (display.isEmpty && !isHovering.value)
              ? null
              : SvgAsset(
                  path: (display.isEmpty && isHovering.value)
                      ? (player1 == 'x' ? xOutlined : oOutlined)
                      : (display == 'x' ? xFilled : oFilled),
                  height: 64,
                  color: tileFilled
                      ? appColors.darkNavy
                      : (isHovering.value && display.isEmpty
                          ? (player1 == 'x'
                              ? appColors.lightBlue
                              : appColors.lightYellow)
                          : (display == 'x'
                              ? appColors.lightBlue
                              : appColors.lightYellow)),
                ),
        ),
      ),
    );
  }
}
