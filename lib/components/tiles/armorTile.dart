import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/ArmorEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

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
      Provider.of<CharacterModel>(context, listen: false).updateArmors(result, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onTap: () {
        Provider.of<CharacterModel>(context, listen: false).toggleStowArmor(index);
      },
      onLongPress: () => _showEditDialog(context),
      child: Card(
        color: armor.stowed ? Colors.black12 : null,
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.75),
                  1: FractionColumnWidth(0.25)
                }, children: [
              TableRow(children: <Widget>[
                Container(
                  child: Text(armor.name,
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(cellPadding),
                ),
                Container(
                  child: Text(armor.weight.toString()+' kg',
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(cellPadding),
                  alignment: Alignment.center,
                ),
              ]),
              TableRow(children: <Widget>[
                Container(
                  child: Text(armor.description,
                      style: Theme.of(context).textTheme.bodyText2),
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
            ]),
          ],
        ),
      ),
    );
  }
}