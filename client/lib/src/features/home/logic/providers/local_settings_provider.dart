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

  void selectBoardSize(int value) {
    log('value: $value');
    if (value < 3) return;
    if (state.boardSize != value) {
      state = state.copyWith(
        boardSize: value,
        align: value == 3
            ? 3
            : value == 4
                ? 4
                :null,
        aligns: value == 3
            ? [3]
            : value == 4
                ? [4]
                : [3, 4],
      );
      log(state.toString());
    }
  }

  void selectAlign(int value) {
    if (state.align != value) {
      state = state.copyWith(
        align: value,
      );
      log(state.toString());
    }
  }
}
