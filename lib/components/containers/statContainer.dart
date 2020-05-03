import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/statTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class StatContainer extends StatelessWidget {
  final List<Stat> stats;
  StatContainer(this.stats);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250.0,
        childAspectRatio: 2,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return StatTile(stats[index], index);
        },
        childCount: stats.length,
      ),
    );
  }
}
