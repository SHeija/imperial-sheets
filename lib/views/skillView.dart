import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/skillTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/skillAddDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
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
      Provider.of<CharacterModel>(context, listen: false).addSkill(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Skill> skills = Provider.of<CharacterModel>(context).getSkills();
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
          padding: EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 190/100,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if(skills[index].canHaveMultiple()){
                  return Dismissible(
                    key: Key('skill $index'),
                    background: Container(color: Theme.of(context).errorColor),
                    onDismissed: (direction) {
                      Provider.of<CharacterModel>(context, listen: false)
                          .removeSkill(skills[index]);
                    },
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialog(
                            child: Text('Delete ${skills[index].name}: ${skills[index].subSkill.toString()}?'),
                          );
                        },
                      );
                    },
                    child: SkillTile(skills[index], index),
                  );
                }else {
                  return SkillTile(skills[index], index);
                }
              },
              childCount: skills.length,
            ),
          ),
        ),
      ],
    );
  }
}
