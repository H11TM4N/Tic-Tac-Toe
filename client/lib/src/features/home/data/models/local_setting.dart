import 'package:tic_tac_toe/src/features/home/data/enums/enums.dart';

class LocalSetting {
  final String player1;
  final DifficultyLevel cpuDifficulty;

  LocalSetting({
    required this.player1,
    required this.cpuDifficulty,
  });

  LocalSetting.empty()
      : player1 = 'x',
        cpuDifficulty = DifficultyLevel.medium;

  @override
  String toString() =>
      'LocalSetting(player1: $player1, cpuDifficulty: $cpuDifficulty)';

  LocalSetting copyWith({
    String? player1,
    DifficultyLevel? cpuDifficulty,
  }) {
    return LocalSetting(
      player1: player1 ?? this.player1,
      cpuDifficulty: cpuDifficulty ?? this.cpuDifficulty,
    );
  }
}
