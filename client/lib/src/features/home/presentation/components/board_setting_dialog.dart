import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/providers.dart';
import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class BoardSettingDialog extends ConsumerStatefulWidget {
  const BoardSettingDialog({super.key});

  @override
  ConsumerState<BoardSettingDialog> get createState =>
      _BoardSettingDialogState();
}

class _BoardSettingDialogState extends ConsumerState<BoardSettingDialog>
    with TickerProviderStateMixin {
  late TabController boardTabController;
  late TabController alignTabController;

  @override
  void initState() {
    super.initState();
    _initializeTabControllers();
  }

  @override
  void dispose() {
    boardTabController.dispose();
    alignTabController.dispose();
    super.dispose();
  }

  void _initializeTabControllers() {
    final boards = ref.read(localSettingProvider).boards;
    final aligns = ref.read(localSettingProvider).aligns;
    final boardSize = ref.read(localSettingProvider).boardSize;
    final align = ref.read(localSettingProvider).align;

    boardTabController = TabController(
      vsync: this,
      length: boards.length,
      initialIndex: boards.indexOf(boardSize),
    );
    alignTabController = TabController(
      vsync: this,
      length: aligns.length,
      initialIndex: aligns.indexOf(align),
    );
  }

  void _updateTabControllers(List<int> boards, List<int> aligns) {
    boardTabController.dispose();
    alignTabController.dispose();

    boardTabController = TabController(
      vsync: this,
      length: boards.length,
      initialIndex: boards.indexOf(ref.read(localSettingProvider).boardSize),
    );
    alignTabController = TabController(
      vsync: this,
      length: aligns.length,
      initialIndex: aligns.indexOf(ref.read(localSettingProvider).align),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boards = ref.watch(localSettingProvider).boards;
    final aligns = ref.watch(localSettingProvider).aligns;

    ref.listen<LocalSetting>(
      localSettingProvider,
      (_, next) {
        _updateTabControllers(next.boards, next.aligns);
      },
    );

    return Container(
      height: 400,
      padding: DeviceType(context).isMobile
          ? EdgeInsets.symmetric(horizontal: 10)
          : null,
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
