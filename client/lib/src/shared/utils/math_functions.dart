import 'dart:math';

int calculateCrossAxisCount(int itemCount) {
  return sqrt(itemCount).ceil();
}

bool getRandomBoolean() {
  final random = Random();
  return random.nextBool();
}
