import 'dart:math';
import 'package:tic_tac_toe/src/features/home/data/constants/winning_conditions.dart';
import 'cpu_strategy.dart';

class MediumCpuStrategy implements CpuStrategy {
  @override
  int decideMove(List<String> board) {
    // Block player if they are about to win
    for (var condition in WINNING_CONDITIONS) {
      int xCount = condition.where((index) => board[index] == 'x').length;
      int emptyCount = condition.where((index) => board[index] == '').length;

      if (xCount == 2 && emptyCount == 1) {
        return condition.firstWhere((index) => board[index] == '');
      }
    }

    // Otherwise, play randomly
    final emptyIndices = List<int>.generate(
      board.length,
      (i) => i,
    ).where((i) => board[i] == '').toList();

    return emptyIndices[Random().nextInt(emptyIndices.length)];
  }
}
