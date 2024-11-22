import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/providers.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class BoardSettingDialog extends HookConsumerWidget {
  const BoardSettingDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final boards = ref.watch(localSettingProvider).boards;
    final aligns = ref.watch(localSettingProvider).aligns;

    final boardSize = ref.watch(localSettingProvider).boardSize;
    final align = ref.watch(localSettingProvider).align;

    final boardTabController = useTabController(
      initialLength: boards.length,
      initialIndex: boards.indexOf(boardSize),
    );
    final alignTabController = useTabController(
      initialLength: aligns.length,
      initialIndex: aligns.indexOf(align),
    );

    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            'SELECT BOARD',
            color: appColors.sliver,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          YBox(15),
          Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: CustomTabBar(
              tabHeight: 40,
              tabController: boardTabController,
              tabs: boards.map((size) => '$size x $size').toList(),
              onTap: (index) => ref
                  .read(localSettingProvider.notifier)
                  .selectBoardSize(boards[index]),
            ),
          ),
          YBox(20),
          AppText(
            'SELECT ALIGN',
            color: appColors.sliver,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          YBox(15),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            child: CustomTabBar(
              tabHeight: 40,
              tabController: alignTabController,
              tabs: aligns.map((size) => '$size').toList(),
              onTap: (index) => ref
                  .read(localSettingProvider.notifier)
                  .selectAlign(aligns[index]),
            ),
          ),
          YBox(40),
          Container(
            constraints: BoxConstraints(
              maxWidth: 150,
            ),
            child: AppButton(
              title: 'DONE',
              onTap: () => AppNavigator.popDialog(),
            ),
          ),
        ],
      ),
    );
  }
}
