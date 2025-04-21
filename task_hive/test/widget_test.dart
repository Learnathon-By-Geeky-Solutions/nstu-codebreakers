import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hive/core/di/di.dart';
import 'package:task_hive/task_hive.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    setupLocator(); // ✅ This MUST be before any widget using GetIt is pumped
  });

  tearDownAll(() async {
    await getIt.reset(); // Clean up GetIt for next test runs
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // 🔥 pumpWidget AFTER setting up dependencies
    await tester.pumpWidget(MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
