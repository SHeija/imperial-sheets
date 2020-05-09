import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/itemTile.dart';
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
          return ItemTile(item: items[index], index: index);
        },
        childCount: items.length,
      ),
    );
  }
}
