import 'package:flutter/material.dart';
import 'file:///C:/Users/Sirkku/dev/imperial-sheets/lib/components/data/armorPointsTable.dart';
import 'file:///C:/Users/Sirkku/dev/imperial-sheets/lib/components/data/weightTable.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class ArmorAndWeightContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character _character = HiveProvider.of(context).getActiveCharacter();
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildListDelegate([
          ArmorPointsTable(
            character: _character,
          ),
          WeightTable(
            character: _character,
          ),
        ]));
  }
}
