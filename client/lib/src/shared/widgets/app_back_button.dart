import 'package:tic_tac_toe/src/features/navigation/nav.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const AppBackButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: onTap ?? () => AppNavigator.popRoute(),
    );
  }
}
