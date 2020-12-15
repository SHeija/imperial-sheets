import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/data/stepIndicator.dart';
import 'package:imperial_sheets/components/dialogs/statEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

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
      final Character character = HiveProvider.of(context).getActiveCharacter();
      character.stats[index] = stat;
      character.save();
    }
  }

  // TILE
  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0;

    return Card(
      child: InkWell(
          onLongPress: () => _showEditDialog(context),
          child: SingleChildScrollView(
            child: Table(columnWidths: {
              0: FractionColumnWidth(0.75),
              1: FractionColumnWidth(0.25)
            }, children: [
              TableRow(children: <Widget>[
                Container(
                  child: Text(stat.name,
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.only(
                      left: cellPadding, top: cellPadding, right: cellPadding),
                ),
                Container(
                  child: Text(stat.value.toString(),
                      style: Theme.of(context).textTheme.headline6),
                  padding: EdgeInsets.only(
                      left: cellPadding, top: cellPadding, right: cellPadding),
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
                      child: StepIndicator(
                        steps: 5,
                        currentSteps: stat.stage,
                      ),
                      padding: EdgeInsets.only(
                          left: cellPadding, right: cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                ),
                Container(
                    child: Chip(
                        backgroundColor: stat.isUnnatural()
                            ? Theme.of(context).accentColor
                            : null,
                        label: Text(stat.getStatBonus().toString()),
                        padding: EdgeInsets.all(0)),
                    padding:
                        EdgeInsets.only(left: cellPadding, right: cellPadding),
                    alignment: Alignment.topCenter),
              ]),
            ]),
          )),
    );
  }
}
