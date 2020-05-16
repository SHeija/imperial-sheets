import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/components/tiles/powerTile.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

class PowerView extends StatelessWidget {
  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          Power _newPower = Power.blank();
          return PowerEditDialog(
            _newPower,
            isNew: true,
          );
        });
    if (result != null) {
     switch (result['choice']) {
       case DialogChoices.confirm:
         Character character = HiveProvider.of(context).getActiveCharacter();
         character.powers.add(result['payload']);
         character.save();
         break;
       default:
         break;
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Power> _powers = character.powers;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showAddDialog(context);
              },
            )
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return PowerTile(_powers[index], index);
              },
              childCount: _powers.length,
            ),
          ),
        ),
      ],
    );
  }
}
