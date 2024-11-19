import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppColumn(
        children: [
          AppButton(
            title: 'NEW GAME (VS CPU)',
            color: appColors.lightYellow,
            hoverColor: appColors.lightYellowHover,
            onTap: () {},
          ),
          YBox(20),
          AppButton(
            title: 'NEW GAME (VS PLAYER)',
            color: appColors.lightBlue,
            hoverColor: appColors.lightBlueHover,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
