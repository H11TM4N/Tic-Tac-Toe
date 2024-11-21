import 'dart:math';
import 'cpu_strategy.dart';

class EasyCpuStrategy implements CpuStrategy {
  @override
  int decideMove(List<String> board) {
    final emptyIndices = List<int>.generate(
      board.length,
      (i) => i,
    ).where((i) => board[i] == '').toList();

    return emptyIndices[Random().nextInt(emptyIndices.length)];
  }
}
