import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/components/tiles/weaponTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

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
     expect(find.text(weapon.name+' '+weapon.getAmountString()), findsOneWidget);
     expect(find.text(weapon.description), findsOneWidget);
     expect(find.text(weapon.weight.toString()+' kg'), findsOneWidget);
     expect(find.text(weapon.getWeight().toString()+' kg'), findsNothing);
     expect(find.text('Range: '+weapon.range), findsOneWidget);
     expect(find.text('Clip: '+weapon.clip), findsOneWidget);
     expect(find.text('Pen: '+weapon.penetration), findsOneWidget);
     expect(find.text('Rld: '+weapon.reloadSpeed), findsOneWidget);
     expect(find.text('Dmg: '+weapon.damage+' '+weapon.type), findsOneWidget);
     expect(find.text('Special: '+weapon.special), findsOneWidget);
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