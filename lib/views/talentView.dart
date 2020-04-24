import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/talentTile.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class TalentView extends StatelessWidget {

  // DIALOG
  void _showAddDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          final Talent _newTalent = Talent.blank();
          return TalentEditDialog(_newTalent);
        }
    );
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).addTalent(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Talent> talents = Provider.of<CharacterModel>(context).getTalents();
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
          padding: EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(color: Theme.of(context).errorColor),
                    key: Key('talent'+index.toString()),
                    onDismissed: (direction) {
                      Provider.of<CharacterModel>(context, listen: false)
                          .removeTalent(talents[index]);
                    },
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialog();
                        },
                      );
                    },
                    child: TalentTile(talents[index], index)
                  );
                },
                childCount: talents.length
            ),
          ),
        )
      ],
    );
  }
}