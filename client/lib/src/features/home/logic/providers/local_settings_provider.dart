import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';

final localSettingProvider =
    StateNotifierProvider<LocalSettingStateNotifier, LocalSetting>((ref) {
  return LocalSettingStateNotifier();
});

class LocalSettingStateNotifier extends StateNotifier<LocalSetting> {
  LocalSettingStateNotifier() : super(LocalSetting.empty());

  void selectMark(String value) {
    if (state.player1 != value) {
      state = state.copyWith(
        player1: value.toLowerCase(),
      );
      log(state.toString());
    }
  }

  void selectCpuDifficulty(DifficultyLevel value) {
    if (state.cpuDifficulty != value) {
      state = state.copyWith(
        cpuDifficulty: value,
      );
      log(state.toString());
    }
  }
}
