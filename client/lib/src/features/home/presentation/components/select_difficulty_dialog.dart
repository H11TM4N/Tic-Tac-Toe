import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/providers.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/features/navigation/routes.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class SelectDifficultyDialog extends HookConsumerWidget {
  const SelectDifficultyDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    const levels = ['EASY', 'MEDIUM', 'HARD'];
    final cpuDiff = ref.read(localSettingProvider).cpuDifficulty;
    final tabController = useTabController(
      initialLength: levels.length,
      initialIndex: levels.indexOf(difficultyLevelToString(cpuDiff)),
    );
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'SELECT DIFFICULTY LEVEL',
            color: appColors.sliver,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          YBox(20),
          Container(
            constraints: BoxConstraints(
              maxWidth: 450,
            ),
            child: CustomTabBar(
              tabController: tabController,
              tabs: levels,
              onTap: (index) => ref
                  .read(localSettingProvider.notifier)
                  .selectCpuDifficulty(stringToDifficultyLevel(levels[index])),
            ),
          ),
          YBox(40),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: AppButton(
              title: 'PROCEED',
              onTap: () {
                ref.read(playerVsCpuGameProvider.notifier).startGame(
                      xTurn: getRandomBoolean(),
                    );
                AppNavigator.pushNamed(HomeRoutes.vsCPU);
              },
            ),
          ),
        ],
      ),
    );
  }
}
