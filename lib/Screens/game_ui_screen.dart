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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WinsnDraws(xnum: 0, ynum: 1, dnum: 2) //numss
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .50,
                child: const Center(
                  child: Text('Game UI will be here'),
                ),
              ),
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
