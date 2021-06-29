import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/skillAddDialog.dart';

void main() {
  group('SkillAddDialog', () {
    testWidgets('renders correctly',
        (WidgetTester tester) async {
      final Widget widget = MaterialApp(
        home: SkillAddDialog(),
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(SkillAddDialog), matchesGoldenFile('skillAddDialog.png'));
    });
  });
}
