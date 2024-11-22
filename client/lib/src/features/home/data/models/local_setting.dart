import 'package:collection/collection.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';

class LocalSetting {
  final String player1;
  final DifficultyLevel cpuDifficulty;
  final int boardSize; // Board size: 3x3, 4x4, ..., 7x7
  final int align; // Number of tiles required to align: 3 or 4
  final List<int> boards;
  final List<int> aligns;

  LocalSetting({
    required this.player1,
    required this.cpuDifficulty,
    required this.boardSize,
    required this.align,
    required this.boards,
    required this.aligns,
  }): assert(boardSize >= 3 && boardSize <= 7, 'Board size must be between 3x3 and 7x7.'),
        assert(align == 3 || align == 4, 'Align must be 3 or 4.'),
        assert(
          (boardSize == 3 && align == 3) || (boardSize >= 4 && (align == 3 || align == 4)),
          '3x3 board supports only align of 3. Boards 4x4 and larger support align of 3 or 4.',
        );

  LocalSetting.empty()
      : player1 = 'x',
        cpuDifficulty = DifficultyLevel.medium,
        boardSize = 3,
        align = 3,
        boards = DEF_BOARD_SIZES,
        aligns = DEF_ALIGNS;

  @override
  String toString() {
    return 'LocalSetting(player1: $player1, cpuDifficulty: $cpuDifficulty, boardSize: $boardSize, align: $align, boards: $boards, aligns: $aligns)';
  }

  LocalSetting copyWith({
    String? player1,
    DifficultyLevel? cpuDifficulty,
    int? boardSize,
    int? align,
    List<int>? boards,
    List<int>? aligns,
  }) {
    return LocalSetting(
      player1: player1 ?? this.player1,
      cpuDifficulty: cpuDifficulty ?? this.cpuDifficulty,
      boardSize: boardSize ?? this.boardSize,
      align: align ?? this.align,
      boards: boards ?? this.boards,
      aligns: aligns ?? this.aligns,
    );
  }

  @override
  bool operator ==(covariant LocalSetting other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.player1 == player1 &&
      other.cpuDifficulty == cpuDifficulty &&
      other.boardSize == boardSize &&
      other.align == align &&
      listEquals(other.boards, boards) &&
      listEquals(other.aligns, aligns);
  }

  @override
  int get hashCode {
    return player1.hashCode ^
      cpuDifficulty.hashCode ^
      boardSize.hashCode ^
      align.hashCode ^
      boards.hashCode ^
      aligns.hashCode;
  }
}
