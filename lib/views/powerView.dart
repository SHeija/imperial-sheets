import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/powerEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
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
      Provider.of<CharacterModel>(context, listen: false).addPower(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Power> _powers = Provider.of<CharacterModel>(context).getPowers();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Imperial sheets'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: (){
                _showAddDialog(context);
              },
            )
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text(_powers[index].name),
                );
              },
            childCount: _powers.length,
          ),
        )
      ],
    );
  }
}