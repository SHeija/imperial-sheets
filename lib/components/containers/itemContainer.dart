import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/itemTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class ItemContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Item> items = character.items;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Dismissible(
            background: Container(color: Theme.of(context).errorColor),
            key: Key('item' + index.toString()),
            onDismissed: (direction) {
              character.skills.removeAt(index);
              character.save();
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ConfirmDialog(
                    child: Text('Delete ${items[index].name}?'),
                  );
                },
              );
            },
            child: ItemTile(item: items[index], index: index),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
