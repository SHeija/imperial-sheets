import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/misc/appInfoButton.dart';
import 'package:imperial_sheets/views/infoView.dart';

void main() {
  group('AppInfoButton', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: AppInfoButton(),
      );

      await tester.pumpWidget(widget);
      expect(find.text('Version'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('tap opens a dialog', (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: AppInfoButton(),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.byType(AppInfoButton));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(InfoView), findsOneWidget);
      expect(find.text('Repository'), findsOneWidget);
      expect(find.text('Licence'), findsOneWidget);
    });
  });
}
