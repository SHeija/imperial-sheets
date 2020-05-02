import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/components/tiles/powerTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class PowerView extends StatelessWidget {

  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          Power _newPower = Power.blank();
          return PowerEditDialog(_newPower);
        }
    );
    if (result != null) {
      Character character = HiveProvider.of(context).getActiveCharacter();
      character.powers.add(result);
      character.save();
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
              onPressed: (){
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
                return Dismissible(
                  background: Container(color: Theme.of(context).errorColor),
                  key: UniqueKey(),
                  onDismissed: (direction){
                    character.powers.removeAt(index);
                    character.save();
                  },
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDialog(
                          child: Text('Delete ${_powers[index].name}?'),
                        );
                      },
                    );
                  },
                  child: PowerTile(_powers[index], index),
                );
              },
              childCount: _powers.length,
            ),
          ),
        ),
      ],
    );
  }
}