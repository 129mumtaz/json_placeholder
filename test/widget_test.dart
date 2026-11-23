import 'package:flutter_test/flutter_test.dart';
import 'package:json_placehlder/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title is displayed.
    expect(find.text('JSONPlaceholder API'), findsOneWidget);
  });
}
