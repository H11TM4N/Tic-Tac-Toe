import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'package:tic_tac_toe/src/features/home/logic/cpu_strategy/cpu_strategy.dart';
import 'package:tic_tac_toe/src/features/home/presentation/components/game_result_dialog.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';
import 'local_settings_provider.dart';

final playerVsCpuGameProvider =
    StateNotifierProvider<PlayerVsCpuGameStateNotifier, GameState>((ref) {
  return PlayerVsCpuGameStateNotifier(setting: ref.read(localSettingProvider));
});

class PlayerVsCpuGameStateNotifier extends StateNotifier<GameState> {
  final LocalSetting setting;
  late List<List<int>> winningConditions;
  PlayerVsCpuGameStateNotifier({
    required this.setting,
  }) : super(GameState.empty()) {
    winningConditions =
        generateWinningConditions(setting.boardSize, setting.align);
  }

  void startGame({
    required bool xTurn,
  }) {
    state = GameState.empty().copyWith(
      boardSize: setting.boardSize,
      align: setting.align,
      player1: setting.player1,
      displayTiles:
          List<String>.filled((setting.boardSize * setting.boardSize), ''),
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
    final move = setting.cpuDifficulty == DifficultyLevel.easy
        ? EasyCpuStrategy().decideMove(state.displayTiles)
        : setting.cpuDifficulty == DifficultyLevel.medium
            ? MediumCpuStrategy(
                boardSize: setting.boardSize,
                align: setting.align,
              ).decideMove(state.displayTiles)
            : HardCpuStrategy(
                boardSize: setting.boardSize,
                align: setting.align,
                cpuSymbol: cpuSymbol,
              ).decideMove(state.displayTiles);
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
    for (var condition in winningConditions) {
      if (condition.every((index) => state.displayTiles[index] == 'x')) {
        _showWinDialog('x', condition);
        return true;
      } else if (condition.every((index) => state.displayTiles[index] == 'o')) {
        _showWinDialog('o', condition);
        return true;
      }
    }
    // Check for a draw
    if (state.filledTiles == (setting.boardSize * setting.boardSize)) {
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
    AppDialog.dialog(
      dismissable: false,
      GameResultDialog(
        isPvP: false,
        player1: state.player1,
        result: winner == state.player1 ? GameResult.win : GameResult.lose,
        onNextRound: goToNextRound,
        onQuit: clearScoreBoard,
      ),
    );
  }

  void _showDrawDialog() {
    state = state.copyWith(
      ties: state.ties + 1,
    );
    AppDialog.dialog(
      dismissable: false,
      GameResultDialog(
        isPvP: false,
        player1: state.player1,
        result: GameResult.draw,
        onNextRound: goToNextRound,
        onQuit: clearScoreBoard,
      ),
    );
  }

  void goToNextRound() {
    state = state.copyWith(
      displayTiles: List.filled((setting.boardSize * setting.boardSize), ''),
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
      player1: setting.player1,
      displayTiles: List.filled((setting.boardSize * setting.boardSize), ''),
    );
  }
}
