import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/for_ingame_ui/wins_and_draws.dart';
import '../utils/buttons.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WinsnDraws(xnum: 0, ynum: 1, dnum: 2) //numss
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                refreshButton(),
                const SizedBox(width: 50),
                homeButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }
}
