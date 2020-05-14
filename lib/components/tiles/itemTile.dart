import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

class ItemTile extends StatelessWidget {
  ItemTile({@required this.item, @required this.index});
  final Item item;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ItemEditDialog(item);
      },
    );

    Future<bool> _confirmDismiss() async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            child: Text('Delete ${item.name}?'),
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
          character.items[index] = result['payload'];
          character.save();
          break;
        case DialogChoices.delete:
          if (await _confirmDismiss()) {
            character.items.removeAt(index);
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
        character.items[index].toggleStow();
        character.save();
      },
      onLongPress: () => _showEditDialog(context),
      child: Card(
        color: item.stowed ? Colors.black12 : null,
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.75),
                1: FractionColumnWidth(0.25)
              },
              children: [
                TableRow(children: <Widget>[
                  Container(
                    child: Text(item.name + ' ' + item.getAmountString(),
                        style: Theme.of(context).textTheme.title),
                    padding: EdgeInsets.all(cellPadding),
                  ),
                  Container(
                    child: Text(item.weight.toString() + ' kg',
                        style: Theme.of(context).textTheme.title),
                    padding: EdgeInsets.all(cellPadding),
                    alignment: Alignment.center,
                  ),
                ]),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(item.description,
                          style: Theme.of(context).textTheme.body1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text(item.stowed ? 'Stowed' : ''),
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
