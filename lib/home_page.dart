import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'widgets/for_home_screen/elevated_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Tic Tac Toe',
                    textStyle: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 400),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
            Center(
              child: SizedBox(
                width: 250.0,
                child: TextLiquidFill(
                  text: 'X O',
                  waveColor: Colors.deepPurple,
                  boxBackgroundColor: Colors.white54,
                  textStyle: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Canterbury',
                  ),
                  boxHeight: 100.0,
                ),
              ),
            ),
            const SizedBox(height: 60),
            const Text(
              'Choose your play mode',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const MyElevatedButton(text: 'With AI'),
            const MyElevatedButton(text: 'With a friend'),
          ],
        ),
      ),
    );
  }
}
