import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/components/tiles/powerTile.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterProvider.dart';
import 'package:provider/provider.dart';

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
      Provider.of<CharacterProvider>(context, listen: false).addPower(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Power> _powers = Provider.of<CharacterProvider>(context).getPowers();
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
                    Provider.of<CharacterProvider>(context, listen: false).removePower(_powers[index]);
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