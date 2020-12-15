import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

class TalentTile extends StatelessWidget {
  TalentTile({
    @required this.talent,
    @required this.index,
  });

  final Talent talent;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return TalentEditDialog(talent);
      },
    );

    Future<bool> _confirmDismiss() async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            child: Text('Delete ${talent.name}?'),
          );
        },
      );
    }

    if (result != null) {
      Character character = HiveProvider.of(context).getActiveCharacter();
      switch (result['choice']) {
        case DialogChoices.cancel:
          break;
        case DialogChoices.confirm:
          character.talents[index] = result['payload'];
          character.save();
          break;
        case DialogChoices.delete:
          if (await _confirmDismiss()) {
            character.talents.removeAt(index);
            character.save();
          }
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return Card(
      child: InkWell(
        onLongPress: () => _showEditDialog(context),
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.75),
                1: FractionColumnWidth(0.25)
              },
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(talent.name,
                          style: Theme.of(context).textTheme.headline6),
                      padding: EdgeInsets.all(cellPadding),
                    ),
                    Container(
                      child: Text('Tier ${talent.tier}',
                          style: Theme.of(context).textTheme.subtitle2),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(talent.description,
                          style: Theme.of(context).textTheme.bodyText2),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
