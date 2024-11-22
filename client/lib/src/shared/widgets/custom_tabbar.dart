import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/shared/shared.dart';

class CustomTabBar extends ConsumerWidget {
  final TabController tabController;
  final List<String> tabs;
  final void Function(int)? onTap;
  final double tabHeight;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.onTap,
    this.tabHeight = 54,
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
            onTap: onTap,
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
                .map((tab) => _buildTab(
                    tab, tabs.indexOf(tab) == tabController.index, tabHeight))
                .toList(),
          ),
        );
      },
    );
  }
}

Widget _buildTab(String text, bool isSelected, double tabHeight) {
  return HookBuilder(
    builder: (context) {
      final isHovered = useState(false);

      return MouseRegion(
        onEnter: (_) => isHovered.value = true,
        onExit: (_) => isHovered.value = false,
        child: Container(
          height: tabHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? appColors.sliver
                : (isHovered.value ? appColors.sliver.withOpacity(.05) : null),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Tab(
            key: ValueKey(text),
            child: text.toLowerCase() == 'x' || text.toLowerCase() == 'o'
                ? SvgAsset(
                    height: 32,
                    path: text.toLowerCase() == 'o' ? oFilled : xFilled,
                    color: isSelected ? appColors.darkNavy : appColors.sliver,
                  )
                : AppText(
                    text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? appColors.darkNavy : appColors.sliver,
                  ),
          ),
        ),
      );
    },
  );
}
