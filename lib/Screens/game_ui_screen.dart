import 'package:flutter/material.dart';
import '../utils/buttons.dart';

class MainUI extends StatelessWidget {
  const MainUI({super.key});

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
