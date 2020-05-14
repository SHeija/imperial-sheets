import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/tiles/talentTile.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class TalentContainer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    List<Talent> talents = character.talents;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return TalentTile(
                talent: talents[index],
                index: index
            );
          },
          childCount: talents.length
      ),
    );
  }
}