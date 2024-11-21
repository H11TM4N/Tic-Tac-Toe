import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/models/game_state.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/game_result_dialog.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

import '../../data/enums/game_result.dart';

final pvpGameProvider =
    StateNotifierProvider<PvPGameStateNotifier, GameState>((ref) {
  return PvPGameStateNotifier();
});

class PvPGameStateNotifier extends StateNotifier<GameState> {
  PvPGameStateNotifier() : super(GameState.empty());

  void startGame({
    required int numOfTiles,
    required String player1,
  }) {
    state = GameState.empty().copyWith(
      player1: player1,
      displayTiles: List<String>.filled(numOfTiles, ''),
    );
  }

  void makeMove(int index) {
    if (state.displayTiles[index] == '') {
      final newDisplayTiles = List<String>.from(state.displayTiles);
      newDisplayTiles[index] = state.xTurn ? 'x' : 'o';

      final filledTiles = newDisplayTiles.where((e) => e.isNotEmpty).length;

      state = state.copyWith(
        displayTiles: newDisplayTiles,
        xTurn: !state.xTurn,
        filledTiles: filledTiles,
      );

      _checkWinner();
    }
  }

  void goToNextRound() {
    state = state.copyWith(
      displayTiles: List.filled(9, ''),
      filledTiles: 0,
      winTiles: [],
    );
  }

  void _checkWinner() {
    // Winning conditions
    List<List<int>> winningConditions = [
      [0, 1, 2], // Row 1
      [3, 4, 5], // Row 2
      [6, 7, 8], // Row 3
      [0, 3, 6], // Column 1
      [1, 4, 7], // Column 2
      [2, 5, 8], // Column 3
      [0, 4, 8], // Diagonal 1
      [2, 4, 6], // Diagonal 2
    ];

    for (var condition in winningConditions) {
      if (state.displayTiles[condition[0]] ==
              state.displayTiles[condition[1]] &&
          state.displayTiles[condition[0]] ==
              state.displayTiles[condition[2]] &&
          state.displayTiles[condition[0]] != '') {
        _showWinDialog(state.displayTiles[condition[0]], condition);
        return;
      }
    }

    // Check for a draw
    if (state.filledTiles == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner, List<int> winTiles) {
    state = state.copyWith(
      xWins: winner == 'x' ? (state.xWins + 1) : null,
      oWins: winner == 'o' ? (state.oWins + 1) : null,
      winTiles: winTiles,
    );
    AppDialog.dialog(GameResultDialog(
      isPvP: true,
      player1: winner,
      result: winner == state.player1 ? GameResult.win : GameResult.lose,
      onNextRound: goToNextRound,
    ));
  }

  void _showDrawDialog() {
    state = state.copyWith(
      ties: state.ties + 1,
    );
    AppDialog.dialog(GameResultDialog(
      isPvP: true,
      player1: '',
      result: GameResult.draw,
      onNextRound: goToNextRound,
    ));
  }

  void clearScoreBoard() {
    state = GameState.empty();
  }
}
