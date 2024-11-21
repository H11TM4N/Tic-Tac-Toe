import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerOneProvider =
    StateNotifierProvider<PlayerStateNotifier, String>((ref) {
  return PlayerStateNotifier();
});

class PlayerStateNotifier extends StateNotifier<String> {
  PlayerStateNotifier() : super('x');

  void selectMark(String value) {
    if (state != value) {
      state = value.toLowerCase();
      log('Player one mark: $state');
    }
  }
}
