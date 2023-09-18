import 'package:flutter/material.dart';
import '../utils/buttons.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              refreshButton(),
              homeButton(context),
            ],
          )
        ],
      ),
    );
  }
}
