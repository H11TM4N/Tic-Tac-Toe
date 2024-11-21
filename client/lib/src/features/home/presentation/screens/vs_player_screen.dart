import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/pvp_game_provider.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/components.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class VsPlayerScreen extends ConsumerWidget {
  const VsPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gameState = ref.watch(pvpGameProvider);

    return Scaffold(
      body: AppColumn(
        centerContent: false,
        children: [
          if (DeviceType(context).isMobile) YBox(15),
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
                          onRestart: () => ref
                              .read(pvpGameProvider.notifier)
                              .clearScoreBoard(),
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
          YBox(50),
          SizedBox(
            height: 430,
            child: GridView.builder(
              itemCount: gameState.displayTiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: calculateCrossAxisCount(
                  gameState.displayTiles.length,
                ),
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (_, index) {
                return PlacementTile(
                  player1: gameState.xTurn ? gameState.player1 : 'o',
                  display: gameState.displayTiles[index],
                  tileFilled: gameState.winTiles.contains(index),
                  onTap: () {
                    ref.read(pvpGameProvider.notifier).makeMove(index);
                  },
                );
              },
            ),
          ),
          // YBox(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScoreContainer(
                    title: 'X (P${gameState.player1 == 'x' ? 1 : 2})',
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
                    title: 'O (P${gameState.player1 == 'x' ? 2 : 1})',
                    score: gameState.oWins,
                    color: appColors.lightYellow,
                  ),
                ],
              ),
            ],
          ),
          // YBox(20),
        ],
      ),
    );
  }
}
