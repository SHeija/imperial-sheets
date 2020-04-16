import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatelessWidget {
  ItemTile(this.item, this.index);
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
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updateItems(result, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onLongPress: () => _showEditDialog(context),
      child: Card(
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
                  child: Text(item.name,
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(cellPadding),
                ),
                Container(
                  child: Text(item.weight.toString()+' kg',
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(cellPadding),
                  alignment: Alignment.center,
                ),
              ]),
              TableRow(children: <Widget>[
                Container(
                  child: Text(item.description,
                      style: Theme.of(context).textTheme.bodyText2),
                  padding: EdgeInsets.all(cellPadding),
                  alignment: Alignment.topLeft,
                ),
                Container(),
              ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}