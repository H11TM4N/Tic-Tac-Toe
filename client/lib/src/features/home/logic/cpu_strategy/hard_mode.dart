import 'dart:math';
import 'cpu_strategy.dart';

class HardCpuStrategy implements CpuStrategy {
  @override
  int decideMove(List<String> board) {
    int bestScore = -9999;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'o'; // CPU plays as 'o'
        int score = _minimax(board, false);
        board[i] = ''; // Undo move
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  int _minimax(List<String> board, bool isMaximizing) {
    String? winner = _checkWinner(board);
    if (winner != null) {
      if (winner == 'o') return 10;
      if (winner == 'x') return -10;
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -9999;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'o';
          int score = _minimax(board, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 9999;
      for (int i = 0; i < board.length; i++) {
        if (board[i] == '') {
          board[i] = 'x';
          int score = _minimax(board, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  String? _checkWinner(List<String> board) {
    List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winningConditions) {
      if (board[condition[0]] == board[condition[1]] &&
          board[condition[0]] == board[condition[2]] &&
          board[condition[0]] != '') {
        return board[condition[0]];
      }
    }

    if (board.every((tile) => tile != '')) return 'draw';

    return null;
  }
}
