import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imperial_sheets/components/common/infoChips.dart';
import 'package:imperial_sheets/components/dialogs/infoEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class InfoContainer extends StatelessWidget {
  InfoContainer(this.character);
  final Character character;

  // Dialog
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return InfoEditDialog(character);
        });

    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updateInfo(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () => _showEditDialog(context),
        child: Container(
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(character.name,
                      style: Theme.of(context).textTheme.headline),
                ),
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text(character.description,
                        style: Theme.of(context).textTheme.body1),
                ),
                InfoChips(character),
              ],
            ),
            ),
        ),
    );
  }
}
