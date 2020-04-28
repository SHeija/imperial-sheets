import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/armorTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterProvider.dart';
import 'package:provider/provider.dart';

class ArmorContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Armor> armors = Provider.of<CharacterProvider>(context).getArmors();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Dismissible(
              background: Container(color: Theme.of(context).errorColor),
              key: UniqueKey(),
              onDismissed: (direction) {
                Provider.of<CharacterProvider>(context, listen: false)
                    .removeArmor(armors[index]);
              },
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      child: Text('Delete ${armors[index].name}?'),
                    );
                  },
                );
              },
              child: ArmorTile(armors[index], index),
            );
          },
          childCount: armors.length
      ),
    );
  }
}