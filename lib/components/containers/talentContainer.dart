import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/components/tiles/talentTile.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class TalentContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Talent> talents = character.talents;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Dismissible(
              background: Container(color: Theme.of(context).errorColor),
              key: Key('talent'+index.toString()),
              onDismissed: (direction) {
                character.talents.removeAt(index);
                character.save();
              },
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      child: Text('Delete ${talents[index].name}?'),
                    );
                  },
                );
              },
              child: TalentTile(
                  talent: talents[index],
                  index: index
              ),
            );
          },
          childCount: talents.length
      ),
    );
  }
}