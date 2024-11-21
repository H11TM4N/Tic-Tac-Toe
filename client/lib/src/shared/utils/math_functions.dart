import 'dart:math';

int calculateCrossAxisCount(int itemCount) {
  return sqrt(itemCount).ceil();
}
