import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/misc/appInfoButton.dart';

void main() {
  group('AppInfoButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: AppInfoButton(),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      expect(find.byType(AboutListTile), findsOneWidget);
      await expectLater(find.byType(AppInfoButton), matchesGoldenFile('appInfoButton.png'));
    });

    testWidgets('tap opens a dialog', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: Scaffold(
          body: Container(
            child: AppInfoButton(),
          ),
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byType(AppInfoButton));
      await tester.pumpAndSettle();
      expect(find.byType(AboutDialog), findsOneWidget);
      expect(find.text('Repository'), findsOneWidget);
    });
  });
}
