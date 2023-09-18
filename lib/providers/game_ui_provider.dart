import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameUIProvider extends ChangeNotifier {
  Icon xButton = const Icon(
    FontAwesomeIcons.x,
    size: 40,
    color: Colors.greenAccent,
  );

  Icon oButton = const Icon(
    FontAwesomeIcons.o,
    size: 40,
    color: Colors.blue,
  );

  IconButton refreshButton() => IconButton(
        onPressed: () {
          clearScoreBoard();
          notifyListeners();
        },
        icon: const Icon(
          Icons.refresh,
          size: 50,
          color: Colors.blueGrey,
        ),
      );

  bool xTurn = true;
  int xWins = 0;
  int yWins = 0;
  int draws = 0;
  int filledBoxes = 0;
  List<String> displayElements = ['', '', '', '', '', '', '', '', ''];

  void onTapped(int index) {
    if (xTurn && displayElements[index] == '') {
      displayElements[index] = 'X';
      filledBoxes++;
    } else if (!xTurn && displayElements[index] == '') {
      displayElements[index] = 'O';
      filledBoxes++;
    }
    xTurn = !xTurn;
    notifyListeners();
  }

  Widget getBoardElement(int index) {
    if (displayElements[index] == 'X') {
      return xButton; // Return the X icon
    } else if (displayElements[index] == 'O') {
      return oButton; // Return the O icon
    } else {
      return const SizedBox.shrink();
    }
  }

  void clearBoard() {
    for (int i = 0; i < 9; i++) {
      displayElements[i] = '';
    }
    filledBoxes = 0;
    notifyListeners();
  }

  void clearScoreBoard() {
    xWins = 0;
    yWins = 0;
    draws = 0;
    for (int i = 0; i < 9; i++) {
      displayElements[i] = '';
    }
    filledBoxes = 0;
    notifyListeners();
  }
}
