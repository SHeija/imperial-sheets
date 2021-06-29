import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/armorEditDialog.dart';
import 'package:imperial_sheets/components/tiles/armorTile.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
 group('ArmorTile', () {
   final Armor armor = Armor('Armor', 'Takes hits', 1.5)
   ..body = 5
   ..head = 5
   ..leftArm = 5
   ..rightArm = 5
   ..leftLeg = 6
   ..rightLeg = 6;

   testWidgets('renders correctly', (WidgetTester tester) async{
     final Widget widget = MaterialApp(
       home: Scaffold(
           body: Container(
               child: ArmorTile(armor, 1),
             ),
       ),
     );

     await tester.pumpWidget(widget);
     await expectLater(find.byType(ArmorTile), matchesGoldenFile('armorTile.png'));
   });

   testWidgets('longpress opens a dialog', (WidgetTester tester) async {
     final Widget widget = MaterialApp(
       home: Scaffold(
         body: Container(
           child: ArmorTile(armor, 1),
         ),
       ),
     );
     await tester.pumpWidget(widget);
     await tester.longPress(find.byType(ArmorTile));
     await tester.pumpAndSettle();

     expect(find.byType(ArmorEditDialog), findsOneWidget);
   });
 });
}