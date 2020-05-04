import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/main.dart';
import 'package:imperial_sheets/views/mainView.dart';
import 'package:imperial_sheets/views/noCharacterView.dart';

void main() {
  //final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
  group('SanityCheck', () {
    testWidgets('Views update when information is changed',
        (WidgetTester tester) async {
      //await binding.setSurfaceSize(Size(1000, 800));
      final widget = App();
      await tester.pumpWidget(widget);
      await tester.pump();
      // nothing
      expect(find.byType(NoCharacterView), findsOneWidget);

      // open drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.byType(Drawer), findsOneWidget);

      // add character
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      // assert that the new character is shown
      expect(find.byType(MainView), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find
          .byType(NoCharacterView), findsNothing);

      // edit info
      expect(find.text('40'), findsNothing);
      await tester.longPress(find.text('Strength'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(FormBuilderTextField), '40');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(find.text('40'), findsOneWidget);

      // assert that new character is in drawer menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text('Name'), findsOneWidget);
    });
  });
}
