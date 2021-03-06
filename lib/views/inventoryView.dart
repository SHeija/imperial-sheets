import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:imperial_sheets/components/containers/armorAndWeightContainer.dart';
import 'package:imperial_sheets/components/containers/armorContainer.dart';
import 'package:imperial_sheets/components/containers/itemContainer.dart';
import 'package:imperial_sheets/components/containers/weaponContainer.dart';
import 'package:imperial_sheets/components/dialogs/armorEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/itemEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/weaponEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

enum Choices { addItem, addWeapon, addArmor }

class InventoryView extends StatelessWidget {
  // DIALOG
  void _showItemAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          Item _newItem = Item.blank();
          return ItemEditDialog(
            _newItem,
            isNew: true,
          );
        });
    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          Character character = HiveProvider.of(context).getActiveCharacter();
          character.items.add(result['payload']);
          character.save();
          break;
        default:
          break;
      }
    }
  }

  void _showWeaponAddDialog(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Weapon _newWeapon = Weapon.blank();
          return WeaponEditDialog(
            _newWeapon,
            isNew: true,
          );
        });
    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          Character character = HiveProvider.of(context).getActiveCharacter();
          character.weapons.add(result['payload']);
          character.save();
          break;
        default:
          break;
      }
    }
  }

  void _showArmorAddDialog(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          Armor _newArmor = Armor.blank();
          return ArmorEditDialog(
            _newArmor,
            isNew: true,
          );
        });
    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          Character character = HiveProvider.of(context).getActiveCharacter();
          character.armors.add(result['payload']);
          character.save();
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
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
          padding: EdgeInsets.all(2.0),
          sliver: ArmorAndWeightContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Weapons'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: WeaponContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Armor'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: ArmorContainer(),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text('Gear'),
            centerTitle: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: ItemContainer(),
        )
      ],
    );
  }
}
