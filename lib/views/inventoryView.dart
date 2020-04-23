import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:imperial_sheets/components/containers/armorAndWeightContainer.dart';
import 'package:imperial_sheets/components/containers/armorContainer.dart';
import 'package:imperial_sheets/components/containers/itemContainer.dart';
import 'package:imperial_sheets/components/containers/weaponContainer.dart';
import 'package:imperial_sheets/components/dialogs/ArmorEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

enum Choices{addItem, addWeapon, addArmor}

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

  void _showArmorAddDialog(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Armor _newArmor = Armor.blank();
          return ArmorEditDialog(_newArmor);
        }
    );
    if (result!=null){
      Provider.of<CharacterModel>(context, listen: false).addArmor(result);
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
                  case Choices.addArmor:
                    _showArmorAddDialog(context);
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
                const PopupMenuItem<Choices>(
                  value: Choices.addArmor,
                  child: Text('Add an armor'),
                )
              ],
            )
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: ArmorAndWeightContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Weapons'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: WeaponContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Armor'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: ArmorContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Gear'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: ItemContainer(),
        )
      ],
    );
  }
}