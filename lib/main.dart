import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/ui/screens/screens.dart';

import 'data/consts/consts.dart';
import 'logic/providers/my_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.route: (context) => const MainMenuScreen(),
          JoinRoomScreen.route: (context) => const JoinRoomScreen(),
          CreateRoomScreen.route: (context) => const CreateRoomScreen(),
          GameScreen.route: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.route,
      ),
    );
  }
}
