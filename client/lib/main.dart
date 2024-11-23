import 'src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future.delayed(
    const Duration(milliseconds: 500),
    () => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}
