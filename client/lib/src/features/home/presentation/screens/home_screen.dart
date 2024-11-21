import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/providers.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/features/navigation/routes.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';
import 'package:tic_tac_toe/src/shared/utils/extensions.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      body: AppColumn(
        children: [
          SvgAsset(path: xAndO),
          YBox(30),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: appColors.semiDarkNavy,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                AppText(
                  'PICK PLAYER 1’S MARK',
                  color: appColors.sliver,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                YBox(20),
                CustomTabBar(
                  tabController: tabController,
                  tabs: ['X', 'O'],
                ),
                YBox(20),
                AppText(
                  'REMEMBER : X GOES FIRST',
                  color: appColors.sliver,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ).withDefaultBoxShadow(),
          YBox(35),
          AppButton(
            title: 'NEW GAME (VS CPU)',
            color: appColors.lightYellow,
            hoverColor: appColors.lightYellowHover,
            onTap: () {
              ref.read(playerVsCpuGameProvider.notifier).startGame(
                    numOfTiles: 9,
                    player1: ref.read(playerOneProvider),
                  );
              AppNavigator.pushNamed(HomeRoutes.vsCPU);
            },
          ),
          YBox(20),
          AppButton(
            title: 'NEW GAME (VS PLAYER)',
            color: appColors.lightBlue,
            hoverColor: appColors.lightBlueHover,
            onTap: () {
              ref.read(pvpGameProvider.notifier).startGame(
                    numOfTiles: 9,
                    player1: ref.read(playerOneProvider),
                  );
              AppNavigator.pushNamed(HomeRoutes.vsPlayer);
            },
          ),
        ],
      ),
    );
  }
}
