import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class StatTile extends StatelessWidget {
  final Stat stat;
  StatTile(this.stat);

  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0;
    const TextStyle topStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return (
    SizedBox(
      width: 190,
      child: Card(
          child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {0: FractionColumnWidth(0.75), 1: FractionColumnWidth(0.25)},
              children: [
                TableRow(
                    children: [
                      Container(
                        child: Text(stat.name, style: topStyle),
                        padding: EdgeInsets.only(left: cellPadding, top: cellPadding, right: cellPadding),
                      ),
                      Container(
                        child: Text(stat.value.toString(), style: topStyle),
                        padding: EdgeInsets.only(left: cellPadding, top: cellPadding, right: cellPadding),
                        alignment: Alignment.center,
                      ),
                    ]
                ),
                TableRow(
                    children: [
                      Container(
                        child: Text(stat.short, style: TextStyle()),
                        padding: EdgeInsets.only(left: cellPadding, bottom: cellPadding, right: cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: Chip(label: Text(stat.getStatBonus().toString()), padding: EdgeInsets.all(0)),
                        padding: EdgeInsets.only(left: cellPadding, bottom: cellPadding, right: cellPadding),
                        alignment: Alignment.topCenter
                      ),
                    ]
                )
              ]

          )
      )
    )
    );
  }
}