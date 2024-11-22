import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'cpu_strategy.dart';

class HardCpuStrategy implements CpuStrategy {
  final String cpuSymbol;
  final int boardSize;
  final int align;

  HardCpuStrategy({
    required this.cpuSymbol,
    required this.boardSize,
    required this.align,
  });

  String get opponentSymbol => cpuSymbol == 'x' ? 'o' : 'x';

  @override
  int decideMove(List<String> displayTiles) {
    final winningConditions = generateWinningConditions(boardSize, align);

    //* Check if CPU can win
    for (var condition in winningConditions) {
      int move = _findWinningMove(displayTiles, condition, cpuSymbol);
      if (move != -1) return move;
    }

    //* Check if CPU needs to block opponent
    for (var condition in winningConditions) {
      int move = _findWinningMove(displayTiles, condition, opponentSymbol);
      if (move != -1) return move;
    }

    //* Take the center if available
    int center = (boardSize * boardSize) ~/ 2;
    if (displayTiles[center] == '') return center;

    //* Take a corner if available
    List<int> corners = _getCorners();
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

    return count == align - 1 && emptyIndex != -1 ? emptyIndex : -1;
  }

  List<int> _getCorners() {
    return [
      0,
      boardSize - 1,
      (boardSize * (boardSize - 1)),
      (boardSize * boardSize) - 1,
    ];
  }
}
