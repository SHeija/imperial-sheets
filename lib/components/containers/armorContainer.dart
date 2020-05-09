import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/armorTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class ArmorContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Armor> armors = character.armors;
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return  ArmorTile(armors[index], index);
      }, childCount: armors.length),
    );
  }
}
