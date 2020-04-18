import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/itemTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class ItemContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<CharacterModel>(context).getItems();
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return Dismissible(
        background: Container(color: Theme.of(context).errorColor),
        key: Key('item' + index.toString()),
        onDismissed: (direction) {
          Provider.of<CharacterModel>(context, listen: false)
              .removeItem(items[index]);
        },
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialog();
            },
          );
        },
        child: ItemTile(items[index], index),
      );
    }, childCount: items.length));
  }
}