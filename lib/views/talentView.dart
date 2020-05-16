import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/containers/talentContainer.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/utils/enums.dart';

class TalentView extends StatelessWidget {
  // DIALOG
  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          final Talent _newTalent = Talent.blank();
          return TalentEditDialog(
            _newTalent,
            isNew: true,
          );
        });
    if (result != null) {
      switch (result['choice']) {
        case DialogChoices.confirm:
          Character character = HiveProvider.of(context).getActiveCharacter();
          character.talents.add(result['payload']);
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _showAddDialog(context);
              },
            )
          ],
          floating: true,
          forceElevated: true,
          elevation: Theme.of(context).appBarTheme.elevation,
        ),
        SliverPadding(
          padding: EdgeInsets.all(2.0),
          sliver: TalentContainer(),
        ),
      ],
    );
  }
}
