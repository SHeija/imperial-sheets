import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/weaponTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class WeaponContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Weapon> weapons = Provider.of<CharacterModel>(context).getWeapons();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Dismissible(
            background: Container(color: Theme.of(context).errorColor),
            key: Key('weapon'+index.toString()),
            onDismissed: (direction) {
              Provider.of<CharacterModel>(context, listen: false)
                  .removeWeapon(weapons[index]);
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmDialog();
                },
              );
            },
            child: WeaponTile(weapons[index], index),
          );
        },
        childCount: weapons.length
      )
    );
  }
}