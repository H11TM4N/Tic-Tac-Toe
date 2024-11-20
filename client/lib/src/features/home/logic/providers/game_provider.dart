import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/models/game_state.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/game_result_dialog.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

import '../../data/enums/game_result.dart';

final gameProvider = StateNotifierProvider<GameStateNotifier, GameState>((ref) {
  return GameStateNotifier();
});

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(GameState.empty());

  void startGame({
    required int numOfTiles,
    required String player1,
  }) {
    state = state.copyWith(
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
    );
  }

  void _checkWinner() {
    // Checking rows
    if (state.filledTiles == 9) {
      _showDrawDialog();
    }
    if (state.displayTiles[0] == state.displayTiles[1] &&
        state.displayTiles[0] == state.displayTiles[2] &&
        state.displayTiles[0] != '') {
      _showWinDialog(state.displayTiles[0]);
    }
    if (state.displayTiles[3] == state.displayTiles[4] &&
        state.displayTiles[3] == state.displayTiles[5] &&
        state.displayTiles[3] != '') {
      _showWinDialog(state.displayTiles[3]);
    }
    if (state.displayTiles[6] == state.displayTiles[7] &&
        state.displayTiles[6] == state.displayTiles[8] &&
        state.displayTiles[6] != '') {
      _showWinDialog(state.displayTiles[6]);
    }

    // Checking Column
    if (state.displayTiles[0] == state.displayTiles[3] &&
        state.displayTiles[0] == state.displayTiles[6] &&
        state.displayTiles[0] != '') {
      _showWinDialog(state.displayTiles[0]);
    }
    if (state.displayTiles[1] == state.displayTiles[4] &&
        state.displayTiles[1] == state.displayTiles[7] &&
        state.displayTiles[1] != '') {
      _showWinDialog(state.displayTiles[1]);
    }
    if (state.displayTiles[2] == state.displayTiles[5] &&
        state.displayTiles[2] == state.displayTiles[8] &&
        state.displayTiles[2] != '') {
      _showWinDialog(state.displayTiles[2]);
    }

    // Checking Diagonal
    if (state.displayTiles[0] == state.displayTiles[4] &&
        state.displayTiles[0] == state.displayTiles[8] &&
        state.displayTiles[0] != '') {
      _showWinDialog(state.displayTiles[0]);
    }
    if (state.displayTiles[2] == state.displayTiles[4] &&
        state.displayTiles[2] == state.displayTiles[6] &&
        state.displayTiles[2] != '') {
      _showWinDialog(state.displayTiles[2]);
    }
  }

  void _showWinDialog(String winner) {
    state = state.copyWith(
      xWins: winner == 'x' ? (state.xWins + 1) : null,
      oWins: winner == 'o' ? (state.oWins + 1) : null,
    );
    AppDialog.dialog(GameResultDialog(
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
      player1: '',
      result: GameResult.draw,
      onNextRound: goToNextRound,
    ));
  }

  void clearScoreBoard() {
    state = GameState.empty();
  }
}
