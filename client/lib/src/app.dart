import 'package:tic_tac_toe/src/features/theme/data/theme.dart';
import 'features/navigation/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: appTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
