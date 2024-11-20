import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class TurnContainer extends StatelessWidget {
  final bool xTurn;
  const TurnContainer({
    super.key,
    required this.xTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: DeviceType(context).isMobile ? 40 : 52,
      width: DeviceType(context).isMobile ? 96 : 140,
      decoration: BoxDecoration(
        color: appColors.semiDarkNavy,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF10212A),
            offset: Offset(0, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgAsset(
            path: xTurn ? xFilled : oFilled,
            height: 17,
            color: appColors.sliver,
          ),
          XBox(8),
          AppText(
            'TURN',
            fontSize: 14,
            height: 0,
            fontWeight: FontWeight.w700,
            color: appColors.sliver,
          ),
        ],
      ),
    );
  }
}
