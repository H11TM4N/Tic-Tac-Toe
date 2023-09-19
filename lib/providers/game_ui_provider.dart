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

  void onTapped(int index, BuildContext context) {
    if (xTurn && displayElements[index] == '') {
      displayElements[index] = 'X';
      filledBoxes++;
    } else if (!xTurn && displayElements[index] == '') {
      displayElements[index] = 'O';
      filledBoxes++;
    }
    xTurn = !xTurn;
    checkWinner(context);
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

  void checkWinner(BuildContext context) {
    if (displayElements[0] == displayElements[1] &&
        displayElements[0] == displayElements[2] &&
        displayElements[0] != '') {
      showWiner(displayElements[0], context);
    }
    if (displayElements[3] == displayElements[4] &&
        displayElements[3] == displayElements[5] &&
        displayElements[3] != '') {
      showWiner(displayElements[3], context);
    }
    if (displayElements[6] == displayElements[7] &&
        displayElements[6] == displayElements[8] &&
        displayElements[6] != '') {
      showWiner(displayElements[6], context);
    }
    if (displayElements[1] == displayElements[4] &&
        displayElements[1] == displayElements[7] &&
        displayElements[1] != '') {
      showWiner(displayElements[1], context);
    }
    if (displayElements[2] == displayElements[5] &&
        displayElements[2] == displayElements[8] &&
        displayElements[2] != '') {
      showWiner(displayElements[2], context);
    }
    if (displayElements[0] == displayElements[3] &&
        displayElements[0] == displayElements[6] &&
        displayElements[0] != '') {
      showWiner(displayElements[0], context);
    }
    if (displayElements[0] == displayElements[4] &&
        displayElements[0] == displayElements[8] &&
        displayElements[0] != '') {
      showWiner(displayElements[0], context);
    }
    if (displayElements[2] == displayElements[4] &&
        displayElements[2] == displayElements[6] &&
        displayElements[2] != '') {
      showWiner(displayElements[2], context);
    } else if (filledBoxes == 9) {
      showDraw(context);
    }
    notifyListeners();
  }

  void showWiner(String winner, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner won'),
          actions: [
            TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                  notifyListeners();
                },
                child: const Text('Play again')),
            TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  notifyListeners();
                },
                child: const Text('Back to home')),
          ],
        );
      },
    );
    if (winner == 'X') {
      xWins++;
    } else if (winner == 'O') {
      yWins++;
    } else {
      draws++;
    }
  }

  void showDraw(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Its a tie'),
          actions: [
            TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text('Play again')),
            TextButton(
                onPressed: () {
                  clearBoard();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Back to home')),
          ],
        );
      },
    );
  }
}
