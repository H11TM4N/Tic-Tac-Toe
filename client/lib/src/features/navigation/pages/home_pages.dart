import 'package:tic_tac_toe/src/features/home/presentation/screens/screens.dart';
import 'package:tic_tac_toe/src/features/navigation/routes.dart';
import 'package:get/get.dart';

List<GetPage> homePages = [
  GetPage(
    name: HomeRoutes.home,
    page: () => const HomeScreen(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: HomeRoutes.vsPlayer,
    page: () => const VsPlayerScreen(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: HomeRoutes.vsCPU,
    page: () => const VsCpuScreen(),
    transition: Transition.native,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
