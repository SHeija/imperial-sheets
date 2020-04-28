import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/containers/skillContainer.dart';
import 'package:imperial_sheets/components/dialogs/skillAddDialog.dart';
import 'package:imperial_sheets/providers/characterProvider.dart';
import 'package:provider/provider.dart';

class SkillView extends StatelessWidget {

  // DIALOG
  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return SkillAddDialog();
        }
    );
    if (result != null) {
      Provider.of<CharacterProvider>(context, listen: false).addSkill(result);
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
