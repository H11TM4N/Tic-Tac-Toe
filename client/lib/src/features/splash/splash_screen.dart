import 'package:tic_tac_toe/src/features/navigation/app_navigator.dart';
import 'package:tic_tac_toe/src/features/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context).colorScheme;

    useEffect(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => AppNavigator.replaceAllNamed(HomeRoutes.home),
      );
      return null;
    }, const []);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.primary,
        ),
      ),
    );
  }
}
