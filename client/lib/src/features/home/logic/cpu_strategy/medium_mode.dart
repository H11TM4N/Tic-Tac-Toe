import 'dart:math';
import 'package:tic_tac_toe/src/features/home/data/constants/winning_conditions.dart';
import 'cpu_strategy.dart';

class MediumCpuStrategy implements CpuStrategy {
  final int boardSize;
  final int align;

  MediumCpuStrategy({
    required this.boardSize,
    required this.align,
  });

  @override
  int decideMove(List<String> board) {
    // Generate winning conditions dynamically
    final winningConditions = generateWinningConditions(boardSize, align);

    // Block player if they are about to win
    for (var condition in winningConditions) {
      int xCount = condition.where((index) => board[index] == 'x').length;
      int emptyCount = condition.where((index) => board[index] == '').length;

      if (xCount == align - 1 && emptyCount == 1) {
        return condition.firstWhere((index) => board[index] == '');
      }
    }

    // Otherwise, play randomly
    final emptyIndices = List<int>.generate(
      board.length,
      (i) => i,
    ).where((i) => board[i] == '').toList();

    return emptyIndices.isNotEmpty
        ? emptyIndices[Random().nextInt(emptyIndices.length)]
        : -1; // Return -1 if no valid move
  }
}
