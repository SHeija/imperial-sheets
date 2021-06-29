import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/statEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';

void main() {
  group('StatEditDialog', (){
    testWidgets('renders correctly', (WidgetTester tester) async{
      final Stat stat = Stat.blank()
      ..name = 'Name'
      ..short = 'Nm'
      ..value = 1
      ..stage = 5
      ..unnaturalBonus = 3;
      final Widget widget = MaterialApp(
        home: StatEditDialog(stat)
      );
      await tester.pumpWidget(widget);
      await expectLater(find.byType(StatEditDialog), matchesGoldenFile('statEditDialog.png'));
    });
  });
}