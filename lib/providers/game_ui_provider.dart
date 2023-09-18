import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameUIProvider extends ChangeNotifier {
  Icon xButton = const Icon(
    FontAwesomeIcons.x,
    size: 40,
    color: Colors.greenAccent,
  );

  Icon oButton = const Icon(
    FontAwesomeIcons.o,
    size: 40,
    color: Colors.blue,
  );
}
