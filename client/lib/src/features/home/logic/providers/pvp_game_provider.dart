import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/local_settings_provider.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/game_result_dialog.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

final pvpGameProvider =
    StateNotifierProvider<PvPGameStateNotifier, GameState>((ref) {
  return PvPGameStateNotifier(setting: ref.read(localSettingProvider));
});

class PvPGameStateNotifier extends StateNotifier<GameState> {
  final LocalSetting setting;
  PvPGameStateNotifier({
    required this.setting,
  }) : super(GameState.empty());

  void startGame({
    required int numOfTiles,
    required bool xTurn,
  }) {
    state = GameState.empty().copyWith(
      player1: setting.player1,
      displayTiles: List<String>.filled(numOfTiles, ''),
      xTurn: xTurn,
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
    for (var condition in WINNING_CONDITIONS) {
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
      onQuit: clearScoreBoard,
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
      onQuit: clearScoreBoard,
    ));
  }

  void clearScoreBoard() {
    state = GameState.empty().copyWith(
      player1: setting.player1,
    );
  }
}
