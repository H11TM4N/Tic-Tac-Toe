import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class RestartButton extends StatelessWidget {
  final VoidCallback onTap;
  const RestartButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: restartIcon,
      height: DeviceType(context).isMobile ? 40 : 52,
      width: DeviceType(context).isMobile ? 40 : 52,
      color: appColors.sliver,
      hoverColor: appColors.sliverhover,
      onTap: onTap,
    );
  }
}

class BoardButton extends StatelessWidget {
  final VoidCallback onTap;
  const BoardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: Icons.grid_on,
      height: DeviceType(context).isMobile ? 40 : 45,
      width: DeviceType(context).isMobile ? 40 : 45,
      color: appColors.sliver,
      hoverColor: appColors.sliverhover,
      onTap: onTap,
    );
  }
}
