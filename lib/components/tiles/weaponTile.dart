import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

class WeaponTile extends StatelessWidget {
  WeaponTile({@required this.weapon, @required this.index});
  final Weapon weapon;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return WeaponEditDialog(weapon);
      },
    );

    Future<bool> _confirmDismiss() async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            child: Text('Delete ${weapon.name}?'),
          );
        },
      );
    }

    if (result != null) {
      Character character = HiveProvider.of(context).getActiveCharacter();
      switch (result['choice']) {
        case DialogChoices.cancel:
          break;
        case DialogChoices.confirm:
          character.weapons[index] = result['payload'];
          character.save();
          break;
        case DialogChoices.delete:
          if (await _confirmDismiss()) {
            character.weapons.removeAt(index);
            character.save();
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onTap: () {
        Character character = HiveProvider.of(context).getActiveCharacter();
        character.weapons[index].toggleStow();
        character.save();
      },
      onLongPress: () => _showEditDialog(context),
      child: Card(
        color: weapon.stowed ? Colors.black12 : null,
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.75),
                1: FractionColumnWidth(0.25)
              },
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(weapon.name + ' ' + weapon.getAmountString(),
                          style: Theme.of(context).textTheme.title),
                      padding: EdgeInsets.all(cellPadding),
                    ),
                    Container(
                      child: Text(weapon.weight.toString() + ' kg',
                          style: Theme.of(context).textTheme.title),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(weapon.description,
                          style: Theme.of(context).textTheme.body1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text(weapon.stowed ? 'Stowed' : ''),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                color: Colors.black12,
              ),
              child: Table(
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Container(
                        child: Text('Range: ${weapon.range}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: Text('RoF: ${weapon.rateOfFire}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: Text('Dmg: ${weapon.damage} ${weapon.type}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Container(
                        child: Text('Pen: ${weapon.penetration}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: Text('Clip: ${weapon.clip}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: Text('Rld: ${weapon.reloadSpeed}',
                            style: Theme.of(context).textTheme.subhead),
                        padding: EdgeInsets.all(cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: Text('Special: ${weapon.special}',
                  style: Theme.of(context).textTheme.subhead),
              padding: EdgeInsets.all(cellPadding),
              alignment: Alignment.topLeft,
            ),
          ],
        ),
      ),
    );
  }
}
