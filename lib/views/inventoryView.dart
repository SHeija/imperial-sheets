import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/containers/itemContainer.dart';
import 'package:imperial_sheets/components/containers/weaponContainer.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

enum Choices{addItem, addWeapon}

class InventoryView extends StatelessWidget {

  // DIALOG
  void _showItemAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context){
          Item _newItem = Item.blank();
          return ItemEditDialog(_newItem);
        }
    );
    if (result!=null){
      Provider.of<CharacterModel>(context, listen: false).addItem(result);
    }
  }

  void _showWeaponAddDialog(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Weapon _newWeapon = Weapon.blank();
          return WeaponEditDialog(_newWeapon);
        }
    );
    if (result!=null){
      Provider.of<CharacterModel>(context, listen: false).addWeapon(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Imperial sheets'),
          floating: true,
          elevation: Theme.of(context).appBarTheme.elevation,
          forceElevated: true,
          actions: <Widget>[
            PopupMenuButton<Choices>(
              icon: Icon(Icons.add),
              onSelected: (Choices result) {
                switch (result) {
                  case Choices.addItem:
                    _showItemAddDialog(context);
                    break;
                  case Choices.addWeapon:
                    _showWeaponAddDialog(context);
                    break;
                  default:
                    print('Whoops!');
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
                const PopupMenuItem<Choices>(
                  value: Choices.addItem,
                  child: Text('Add an item'),
                ),
                const PopupMenuItem<Choices>(
                  value: Choices.addWeapon,
                  child: Text('Add a weapon'),
                ),
              ],
            )
          ],
        ),
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