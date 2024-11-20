import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/player_one_provider.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class CustomTabBar extends ConsumerWidget {
  final TabController tabController;
  final List<String> tabs;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context, ref) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            color: appColors.darkNavy,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TabBar(
            controller: tabController,
            isScrollable: false,
            onTap: (index) =>
                ref.read(playerOneProvider.notifier).selectMark(tabs[index]),
            labelStyle: TextStyle(
              color: appColors.darkNavy,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              fontFamily: outfit,
            ),
            unselectedLabelColor: appColors.sliver,
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: appColors.darkNavy.withOpacity(.1),
            ),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs
                .map((tab) =>
                    _buildTab(tab, tabs.indexOf(tab) == tabController.index))
                .toList(),
          ),
        );
      },
    );
  }
}

Widget _buildTab(String text, bool isSelected) {
  return HookBuilder(
    builder: (context) {
      final isHovered = useState(false);

      return MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: Container(
          height: 54,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? appColors.sliver
                : (isHovered.value ? appColors.sliver.withOpacity(.05) : null),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Tab(
            child: SvgAsset(
              height: 32,
              path: text.toLowerCase() == 'o' ? oFilled : xFilled,
              color: isSelected ? appColors.darkNavy : appColors.sliver,
            ),
          ),
        ),
      );
    },
  );
}
