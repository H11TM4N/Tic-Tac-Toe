import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/src/app.dart';

void main() {
  testWidgets('App initializes and displays MyApp widget', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );

      // Simulate waiting for asynchronous operations
      await tester.pumpAndSettle();

      // Verify that MyApp is displayed
      expect(find.byType(MyApp), findsOneWidget);
    });
  });
}
