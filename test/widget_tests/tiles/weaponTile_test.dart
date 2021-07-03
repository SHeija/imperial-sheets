import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/components/tiles/weaponTile.dart';
import 'package:imperial_sheets/models/equipment.dart';

void main() {
 group('WeaponTile', () {
   final Weapon weapon = Weapon('Gun', 'Shoots bullets', 1.5)
   ..range='20m'
   ..clip='20'
   ..special='Yolo'
   ..reloadSpeed='2Full'
   ..damage='1d10+1'
   ..type='Impact'
   ..penetration="3"
   ..amount = 3;

   testWidgets('renders correctly', (WidgetTester tester) async{
     final Widget widget = MaterialApp(
       home: Scaffold(
           body: Container(
               child: WeaponTile(
                 weapon: weapon,
                 index: 1,
               ),
             ),
       ),
     );

     await tester.pumpWidget(widget);
     await expectLater(find.byType(WeaponTile), matchesGoldenFile('weaponTile.png'));
   });

   testWidgets('longpress opens a dialog', (WidgetTester tester) async {
     final Widget widget = MaterialApp(
       home: Scaffold(
         body: Container(
           child: WeaponTile(
             weapon: weapon,
             index: 1,
           ),
         ),
       ),
     );
     await tester.pumpWidget(widget);
     await tester.longPress(find.byType(WeaponTile));
     await tester.pumpAndSettle();

     expect(find.byType(WeaponEditDialog), findsOneWidget);
   });
 });
}