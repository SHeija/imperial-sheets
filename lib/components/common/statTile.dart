import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/statEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class StatTile extends StatelessWidget {
  StatTile(this.stat, this.index);
  final Stat stat;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatEditDialog(stat);
      },
    );
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updateStats(result, index);
    }
  }

  // TILE
  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0;

    return SizedBox(
      width: 190,
      child: GestureDetector(
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
                    child: Text(stat.name,
                        style: Theme.of(context).textTheme.headline6),
                    padding: EdgeInsets.only(
                        left: cellPadding,
                        top: cellPadding,
                        right: cellPadding),
                  ),
                  Container(
                    child: Text(stat.value.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    padding: EdgeInsets.only(
                        left: cellPadding,
                        top: cellPadding,
                        right: cellPadding),
                    alignment: Alignment.center,
                  ),
                ]),
                TableRow(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(stat.short,
                            style: Theme.of(context).textTheme.bodyText2),
                        padding: EdgeInsets.only(
                            left: cellPadding,
                            bottom: cellPadding,
                            right: cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: StepIndicator(5, stat.stage,
                            Theme.of(context).accentColor, Colors.grey),
                        padding: EdgeInsets.only(
                            left: cellPadding,
                            right: cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                  Container(
                      child: Chip(
                          label: Text(stat.getStatBonus().toString()),
                          padding: EdgeInsets.all(0)),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          right: cellPadding),
                      alignment: Alignment.topCenter),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
