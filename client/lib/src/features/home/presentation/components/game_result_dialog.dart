import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/features/home/data/enums/game_result.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class GameResultDialog extends StatelessWidget {
  final String player1;
  final GameResult result;
  final VoidCallback onNextRound;
  final bool isPvP;
  const GameResultDialog({
    super.key,
    required this.player1,
    required this.result,
    required this.onNextRound,
    required this.isPvP,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 228,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (result == GameResult.draw)
            AppText(
              'ROUND TIED',
              color: appColors.sliver,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )
          else ...[
            AppText(
              isPvP
                  ? 'PLAYER ${player1 == 'x' && result == GameResult.win ? 1 : 2}  WINS!'
                  : (result == GameResult.win
                      ? 'YOU WON!'
                      : 'OH NO, YOU LOST…'),
              color: appColors.sliver,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            YBox(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgAsset(
                  path: player1 == 'x' ? xFilled : oFilled,
                  height: 28,
                ),
                XBox(5),
                AppText(
                  'TAKES THE ROUND',
                  color: player1 == 'x'
                      ? appColors.lightBlue
                      : appColors.lightYellow,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
          YBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton.small(
                width: 76,
                title: 'QUIT',
                color: appColors.sliver,
                hoverColor: appColors.sliverhover,
                onTap: () {
                  AppNavigator.popRoute();
                },
              ),
              XBox(12),
              AppButton.small(
                width: 146,
                title: 'NEXT ROUND',
                color: appColors.lightYellow,
                hoverColor: appColors.lightYellowHover,
                onTap: () {
                  onNextRound();
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
