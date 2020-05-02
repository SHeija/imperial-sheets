import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/weaponTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class WeaponContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Weapon> weapons = character.weapons;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Dismissible(
            background: Container(color: Theme.of(context).errorColor),
            key: Key('weapon'+index.toString()),
            onDismissed: (direction) {
              character.weapons.removeAt(index);
              character.save();
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmDialog(
                    child: Text('Delete ${weapons[index].name}?')
                  );
                },
              );
            },
            child: WeaponTile(
                weapon: weapons[index],
                index: index
            ),
          );
        },
        childCount: weapons.length
      )
    );
  }
}