import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/models/game_state.dart';
import 'package:tic_tac_toe/src/features/home/data/winning_conditions.dart';
import 'package:tic_tac_toe/src/features/home/logic/cpu_strategy/hard_mode.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/game_result_dialog.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

import '../../data/enums/game_result.dart';
import 'player_one_provider.dart';

final playerVsCpuGameProvider =
    StateNotifierProvider<PlayerVsCpuGameStateNotifier, GameState>((ref) {
  return PlayerVsCpuGameStateNotifier(player1: ref.read(playerOneProvider));
});

class PlayerVsCpuGameStateNotifier extends StateNotifier<GameState> {
  final String player1;
  PlayerVsCpuGameStateNotifier({required this.player1,}) : super(GameState.empty());

  void startGame({
    required int numOfTiles,
    required bool xTurn,
  }) {
    state = GameState.empty().copyWith(
      player1: player1,
      displayTiles: List<String>.filled(numOfTiles, ''),
      xTurn: xTurn,
    );
    if ((state.player1 == 'x' ? !state.xTurn : state.xTurn)) {
      Future.delayed(Duration(seconds: 1), _cpuMove);
    }
  }

  void makeMove(int index) {
    // Player's turn
    if (state.displayTiles[index] == '' &&
        (state.player1 == 'x' ? state.xTurn : !state.xTurn)) {
      _placeMove(index, state.player1);
      if (!_checkWinner()) {
        // CPU plays after the player
        Future.delayed(Duration(seconds: 1), _cpuMove);
      }
    }
  }

  void _cpuMove() {
    String cpuSymbol = state.player1 == 'x' ? 'o' : 'x';
    final move = HardCpuStrategy(cpuSymbol).decideMove(state.displayTiles);
    _placeMove(move, cpuSymbol);
    _checkWinner();
  }

  void _placeMove(int index, String symbol) {
    final newDisplayTiles = List<String>.from(state.displayTiles);
    newDisplayTiles[index] = symbol;

    final filledTiles = newDisplayTiles.where((e) => e.isNotEmpty).length;

    state = state.copyWith(
      displayTiles: newDisplayTiles,
      xTurn: symbol == 'o', // Toggle turns
      filledTiles: filledTiles,
    );
  }

  bool _checkWinner() {
    for (var condition in WINNING_CONDITIONS) {
      if (state.displayTiles[condition[0]] ==
              state.displayTiles[condition[1]] &&
          state.displayTiles[condition[0]] ==
              state.displayTiles[condition[2]] &&
          state.displayTiles[condition[0]] != '') {
        _showWinDialog(state.displayTiles[condition[0]], condition);
        return true;
      }
    }

    if (state.filledTiles == 9) {
      _showDrawDialog();
      return true;
    }

    return false;
  }

  void _showWinDialog(String winner, List<int> winTiles) {
    state = state.copyWith(
      xWins: winner == 'x' ? (state.xWins + 1) : null,
      oWins: winner == 'o' ? (state.oWins + 1) : null,
      winTiles: winTiles,
    );
    AppDialog.dialog(GameResultDialog(
      isPvP: false,
      player1: state.player1,
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
      isPvP: false,
      player1: state.player1,
      result: GameResult.draw,
      onNextRound: goToNextRound,
      onQuit: clearScoreBoard,
    ));
  }

  void goToNextRound() {
    state = state.copyWith(
      displayTiles: List.filled(9, ''),
      filledTiles: 0,
      winTiles: [],
    );
    // Check if the CPU starts the new round
    if (!(state.player1 == 'x' ? state.xTurn : !state.xTurn)) {
      Future.delayed(Duration(seconds: 1), _cpuMove);
    }
  }

  void clearScoreBoard() {
    state = GameState.empty().copyWith(
      player1: player1,
    );
  }
}
