List<List<int>> generateWinningConditions(int boardSize, int align) {
  List<List<int>> winningConditions = [];

  // Generate row conditions
  for (int row = 0; row < boardSize; row++) {
    for (int col = 0; col <= boardSize - align; col++) {
      List<int> condition = [];
      for (int k = 0; k < align; k++) {
        condition.add(row * boardSize + col + k);
      }
      winningConditions.add(condition);
    }
  }

  // Generate column conditions
  for (int col = 0; col < boardSize; col++) {
    for (int row = 0; row <= boardSize - align; row++) {
      List<int> condition = [];
      for (int k = 0; k < align; k++) {
        condition.add((row + k) * boardSize + col);
      }
      winningConditions.add(condition);
    }
  }

  // Generate diagonal conditions (top-left to bottom-right)
  for (int row = 0; row <= boardSize - align; row++) {
    for (int col = 0; col <= boardSize - align; col++) {
      List<int> condition = [];
      for (int k = 0; k < align; k++) {
        condition.add((row + k) * boardSize + col + k);
      }
      winningConditions.add(condition);
    }
  }

  // Generate diagonal conditions (top-right to bottom-left)
  for (int row = 0; row <= boardSize - align; row++) {
    for (int col = align - 1; col < boardSize; col++) {
      List<int> condition = [];
      for (int k = 0; k < align; k++) {
        condition.add((row + k) * boardSize + col - k);
      }
      winningConditions.add(condition);
    }
  }

  return winningConditions;
}
