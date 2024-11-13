import 'package:tic_tac_toe/src/app_injection_container.dart';
import 'src/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjectionContainer.init();
  Future.delayed(
    const Duration(milliseconds: 500),
    () => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}
