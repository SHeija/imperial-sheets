import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/statTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class StatContainer extends StatelessWidget {
  final List<Stat> stats;
  StatContainer(this.stats);

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = stats.map((e) => StatTile(e, stats.indexOf(e))).toList();

    return (Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Wrap(
        direction: Axis.horizontal,
        children: widgets
      ),
    ));
  }
}
