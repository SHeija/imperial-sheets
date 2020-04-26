import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/statEditDialog.dart';
import 'package:imperial_sheets/components/tiles/statTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import '../utils/constants.dart' as Constants;

void main() {
  testWidgets('StatTile structure and function', (WidgetTester tester) async {
    final Stat stat = Stat(Constants.WP, 'WP', 25, 0);
    final Widget testableWidget = MaterialApp(
      home: Scaffold(
        body: Container(
          child: StatTile(stat,1),
        ),
      ),
    );
    await tester.pumpWidget(testableWidget);
    await tester.pumpAndSettle();

    expect(find.text(Constants.WP), findsOneWidget);
    expect(find.text('WP'), findsOneWidget);
    expect(find.text('25'), findsOneWidget);
    expect(find.widgetWithText(Chip, '2'), findsOneWidget );
    expect(find.byType(StepIndicator), findsOneWidget);

    // Check that dialog opens
    await tester.longPress(find.byType(StatTile));
    await tester.pumpAndSettle();
    expect(find.byType(StatEditDialog), findsOneWidget);

  });
}
