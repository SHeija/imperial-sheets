import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/containers/itemContainer.dart';
import 'package:imperial_sheets/components/containers/weaponContainer.dart';

class InventoryView extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: WeaponContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: ItemContainer(),
        )
      ],
    );
  }
}
