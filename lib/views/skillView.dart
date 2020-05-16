import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/containers/skillContainer.dart';
import 'package:imperial_sheets/components/dialogs/skillAddDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class SkillView extends StatelessWidget {
  // DIALOG
  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return SkillAddDialog();
        });
    if (result != null) {
      Character _character = HiveProvider.of(context).getActiveCharacter();
      _character.skills.add(result);
      _character.sortSkills();
      _character.save();
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
          sliver: SkillContainer(),
        ),
      ],
    );
  }
}
