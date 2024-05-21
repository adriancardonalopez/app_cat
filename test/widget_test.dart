import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_app/main.dart';

void main() {
testWidgets('Verify if CatListScreen shows up', (WidgetTester tester) async {
// Build our app and trigger a frame.
await tester.pumpWidget(MyApp());

// Verify that CatListScreen is showing.
expect(find.text('Cats'), findsOneWidget);
expect(find.text('No cats found'), findsNothing);

// Test for loading indicator initially.
expect(find.byType(CircularProgressIndicator), findsOneWidget);

// Simulate network response by pumping the widget again.
// Ideally, you would mock the ApiService to provide test data here.
await tester.pump(); // Add duration if you simulate a delay.

// Verify that CircularProgressIndicator is gone.
expect(find.byType(CircularProgressIndicator), findsNothing);
});
}
