import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/data/armorPointsTable.dart';
import 'package:imperial_sheets/components/data/weightTable.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class ArmorAndWeightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character _character = HiveProvider.of(context).getActiveCharacter();
    return SliverGrid.count(
      crossAxisCount: 2,
      children: [
        ArmorPointsTable(
          character: _character,
        ),
        WeightTable(
          character: _character,
        ),
      ],
      childAspectRatio: 1,
    );
  }
}
