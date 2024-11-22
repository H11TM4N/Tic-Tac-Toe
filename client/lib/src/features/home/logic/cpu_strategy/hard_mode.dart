import 'package:tic_tac_toe/src/features/home/data/constants/winning_conditions.dart';
import 'cpu_strategy.dart';

class HardCpuStrategy implements CpuStrategy {
  final String cpuSymbol;

  HardCpuStrategy(this.cpuSymbol);

  String get opponentSymbol => cpuSymbol == 'x' ? 'o' : 'x';

  @override
  int decideMove(List<String> displayTiles) {
    //* Check if CPU can win
    for (var condition in WINNING_CONDITIONS) {
      int move = _findWinningMove(displayTiles, condition, cpuSymbol);
      if (move != -1) return move;
    }

    //* Check if CPU needs to block opponent
    for (var condition in WINNING_CONDITIONS) {
      int move = _findWinningMove(displayTiles, condition, opponentSymbol);
      if (move != -1) return move;
    }

    //* Take the center if available
    if (displayTiles[4] == '') return 4;

    //* Take a corner if available
    List<int> corners = [0, 2, 6, 8];
    for (var corner in corners) {
      if (displayTiles[corner] == '') return corner;
    }

    //* Take any available move
    for (int i = 0; i < displayTiles.length; i++) {
      if (displayTiles[i] == '') return i;
    }

    return -1; // No valid move
  }

  int _findWinningMove(
      List<String> displayTiles, List<int> condition, String symbol) {
    int count = 0;
    int emptyIndex = -1;

    for (var index in condition) {
      if (displayTiles[index] == symbol) {
        count++;
      } else if (displayTiles[index] == '') {
        emptyIndex = index;
      }
    }

    return count == 2 && emptyIndex != -1 ? emptyIndex : -1;
  }
}
