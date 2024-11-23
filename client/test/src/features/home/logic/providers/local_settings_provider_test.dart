import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/features/home/data/data.dart';
import 'package:tic_tac_toe/src/features/home/logic/providers/local_settings_provider.dart';

void main() {
  late ProviderContainer container;
  late LocalSettingStateNotifier notifier;

  setUp(() {
    container = ProviderContainer();
    notifier = container.read(localSettingProvider.notifier);
  });

  group('Local Settings Provider -', () {
    group('Initial State', () {
      test('Should be of type [LocalSetting] when instanciated', () {
        expect(
          container.read(localSettingProvider),
          isA<LocalSetting>(),
        );
      });
      test('Should be [LocalSetting.empty()] when instanciated', () {
        expect(
          container.read(localSettingProvider),
          LocalSetting.empty(),
        );
      });
    });
    group('Select Mark function', () {
      test('Should remain the same if value is neither x nor o', () {
        final initialState = container.read(localSettingProvider);
        notifier.selectMark('y');
        final updatedState = container.read(localSettingProvider);

        expect(updatedState.player1, initialState.player1);
      });
      test('Select mark', () {
        final value = 'x';
        notifier.selectMark(value);

        expect(
          container.read(localSettingProvider).player1,
          value,
        );
      });
    });
    test('Select CPU Difficulty', () {
      final value = DifficultyLevel.easy;
      notifier.selectCpuDifficulty(value);

      expect(
        container.read(localSettingProvider).cpuDifficulty,
        value,
      );
    });
    group('Select Board Size function', () {
      test('Should remain the same if (value < 3 || value > 7)', () {
        final value = 1;
        final initialState = container.read(localSettingProvider);
        notifier.selectBoardSize(value);
        final updatedState = container.read(localSettingProvider);

        expect(updatedState.boardSize, initialState.boardSize);
      });
      test('Select board size', () {
        final value = 5;
        notifier.selectBoardSize(value);

        expect(
          container.read(localSettingProvider).boardSize,
          value,
        );
      });
    });
    group('Select Align Function', () {
      test('Should remain the same if (value < 3 || value > 4)', () {
        final value = 1;
        final initialState = container.read(localSettingProvider);
        notifier.selectAlign(value);
        final updatedState = container.read(localSettingProvider);

        expect(updatedState.align, initialState.align);
      });

      test('Select align', () {
        final value = 3;
        notifier.selectAlign(value);

        expect(
          container.read(localSettingProvider).align,
          value,
        );
      });
    });
  });
}
