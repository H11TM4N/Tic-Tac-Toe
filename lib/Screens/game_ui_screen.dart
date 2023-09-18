import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game_ui_provider.dart';
import 'package:tic_tac_toe/widgets/for_ingame_ui/wins_and_draws.dart';
import '../utils/buttons.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    GameUIProvider gameUIProvider = Provider.of<GameUIProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WinsnDraws(
                  xnum: gameUIProvider.xWins,
                  ynum: gameUIProvider.yWins,
                  dnum: gameUIProvider.draws,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .50,
                child: Center(
                  child: Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext contex, index) {
                        return GestureDetector(
                          onTap: () {
                            gameUIProvider.onTapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                            ),
                            child: Center(
                              child: Center(
                                child: gameUIProvider.getBoardElement(
                                    index), // Use getBoardElement to display icons
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gameUIProvider.refreshButton(),
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
