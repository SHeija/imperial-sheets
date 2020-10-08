import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imperial_sheets/components/data/infoChips.dart';
import 'package:imperial_sheets/components/dialogs/infoEditDialog.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/utils/enums.dart';

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
      },
    );
    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          character.name = result['payload'].name;
          character.description = result['payload'].description;
          character.save();
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool timeStampOn = HiveProvider.of(context).settings.get('Display editing timestamps');
    return Container(
        child: Card(
          child: Column(
            children: <Widget>[
              InkWell(
                onLongPress: () => _showEditDialog(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(character.name,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: timeStampOn ? Text('Last edited: ${character.lastEdited.day}.${character.lastEdited.month}.${character.lastEdited.year} ${character.lastEdited.hour}:${character.lastEdited.minute}') : null,
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(character.description,
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
              ),
              InfoChips(character),
            ],
          ),
      ),
    );
  }
}
