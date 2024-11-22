export 'easy_mode.dart';
export 'medium_mode.dart';
export 'hard_mode.dart';

abstract class CpuStrategy {
  int decideMove(List<String> board);
}
