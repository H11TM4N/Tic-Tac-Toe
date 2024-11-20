import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class RestartGameDialog extends StatelessWidget {
  final VoidCallback onRestart;
  const RestartGameDialog({
    super.key,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 228,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'RESTART GAME?',
            color: appColors.sliver,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          YBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton.small(
                width: 139,
                title: 'NO, CANCEL',
                color: appColors.sliver,
                hoverColor: appColors.sliverhover,
                onTap: () => AppNavigator.popDialog(),
              ),
              XBox(12),
              AppButton.small(
                width: 151,
                title: 'YES, RESTART',
                color: appColors.lightYellow,
                hoverColor: appColors.lightYellowHover,
                onTap: (){
                  onRestart();
                  AppNavigator.popDialog();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
