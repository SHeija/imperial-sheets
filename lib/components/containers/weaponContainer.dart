import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/weaponTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class WeaponContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Weapon> weapons = character.weapons;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return WeaponTile(
              weapon: weapons[index],
              index: index
          );
        },
        childCount: weapons.length
      )
    );
  }
}