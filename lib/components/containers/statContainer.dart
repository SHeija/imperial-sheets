import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/statTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class StatContainer extends StatelessWidget {
  final List<Stat> stats;
  StatContainer(this.stats);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 190/90,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return StatTile(stats[index], index);
          },
          childCount: stats.length,
        ),
      ),
    );
  }
}
