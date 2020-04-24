import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class PowerTile extends StatelessWidget {
  PowerTile(this.power, this.index);
  final Power power;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return PowerEditDialog(power);
      },
    );
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updatePowers(result, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onLongPress: () =>
          _showEditDialog(context),
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
                  child: Text(power.name,
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.all(cellPadding),
                ),
                Container(
                ),
              ]),
              TableRow(
                children: <Widget>[
                  Container(
                    child: Text(power.description,
                        style: Theme.of(context).textTheme.bodyText2),
                    padding: EdgeInsets.all(cellPadding),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                  ),
                ],
              ),
            ]),
            Container(
              padding: EdgeInsets.only(top: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                color: Colors.black12,
              ),
              child: Table(
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    Container(
                      child: Text('Action: ${power.action}',
                          style: Theme.of(context).textTheme.subtitle1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text('Focus Power: ${power.focusPower}',
                          style: Theme.of(context).textTheme.subtitle1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text('Range: ${power.range}',
                          style: Theme.of(context).textTheme.subtitle1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                  ),
                  TableRow(children: <Widget>[
                    Container(
                      child: Text('Sustained: ${power.sustained}',
                          style: Theme.of(context).textTheme.subtitle1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(
                      child: Text('Subtype: ${power.subType}',
                          style: Theme.of(context).textTheme.subtitle1),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(),
                  ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: Text('Effect: ${power.effect}',
                  style: Theme.of(context).textTheme.subtitle1),
              padding: EdgeInsets.all(cellPadding),
              alignment: Alignment.topLeft,
            ),
          ],
        ),
      ),
    );
  }
}