import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/ArmorEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class ArmorTile extends StatelessWidget {
  ArmorTile(this.armor, this.index);
  final Armor armor;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ArmorEditDialog(armor);
      },
    );
    if (result != null) {
      Character character = HiveProvider.of(context).getActiveCharacter();
      character.armors[index] = result;
      character.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onTap: () {
        Character character = HiveProvider.of(context).getActiveCharacter();
        character.armors[index].toggleStow();
        character.save();
      },
      onLongPress: () => _showEditDialog(context),
      child: Card(
        color: armor.stowed ? Colors.black12 : null,
        child: Column(
          children: <Widget>[
            Table(
              columnWidths: {
                0: FractionColumnWidth(0.75),
                1: FractionColumnWidth(0.25)
              },
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(armor.name + ' ' + armor.getAmountString(),
                          style: Theme.of(context).textTheme.title),
                      padding: EdgeInsets.all(cellPadding),
                    ),
                    Container(
                      child: Text(armor.weight.toString() + ' kg',
                          style: Theme.of(context).textTheme.title),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(armor.description,
                          style: Theme.of(context).textTheme.body1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text(armor.stowed ? 'Stowed' : ''),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
