import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/statTile.dart';

class StatGrid extends StatelessWidget {
  final stats;
  StatGrid(this.stats);

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = [];
    stats.forEach((e) => widgets.add(StatTile(e)));

    return (Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        children: widgets,
      ),
    ));
  }
}
