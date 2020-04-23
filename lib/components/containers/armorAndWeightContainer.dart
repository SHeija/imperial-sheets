import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/armorPointsTable.dart';
import 'package:imperial_sheets/components/common/weightCounter.dart';

class ArmorAndWeightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // A hack to get two different-width boxes next to each other, into a customScrollView, and without clipping issues SliverToBoxAdapter has
    // Basically a 1x1 grid with a Row inside it
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500.0,
        childAspectRatio: 500/325,
      ),
      delegate: SliverChildListDelegate(
        [
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                ArmorPointsTable(),
                Expanded(
                  child: WeightCounter(),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}