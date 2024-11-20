import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/game_provider.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/components.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class VsPlayerScreen extends ConsumerWidget {
  const VsPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      body: AppColumn(
        shouldScroll: false,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgAsset(path: xAndO),
                  RestartButton(
                    onTap: () {
                      AppDialog.dialog(
                        RestartGameDialog(
                          onRestart: () =>
                              ref.read(gameProvider.notifier).clearScoreBoard(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              TurnContainer(
                xTurn: gameState.xTurn,
              ),
            ],
          ),
          YBox(20),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (_, index) {
                return PlacementTile(
                  player1: gameState.xTurn ? gameState.player1 : 'o',
                  display: gameState.displayTiles[index],
                  tileFilled: false,
                  onTap: () {
                    ref.read(gameProvider.notifier).makeMove(index);
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreContainer(
                title: 'X (YOU)',
                score: gameState.xWins,
                color: appColors.lightBlue,
              ),
              XBox(15),
              ScoreContainer(
                title: 'TIES',
                score: gameState.ties,
                color: appColors.sliver,
              ),
              XBox(15),
              ScoreContainer(
                title: 'O (CPU)',
                score: gameState.oWins,
                color: appColors.lightYellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
