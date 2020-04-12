import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/dialogs/singleValueEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

import 'dialogs/dualValueEditDialog.dart';

class InfoChips extends StatelessWidget {
  InfoChips(this.character);
  final Character character;

  Future<void> _showSingleValueDialog(BuildContext context, dynamic value, String type) async {
    final result = await showDialog<dynamic>(
      context: context,
      builder: (context) {
        return(
          SingleValueEditDialog(value, type)
        );
      }
    );

    if (result!=null) {
      switch (type) {
        case 'Corruption':
          character.corruption = result;
          break;
        case 'Insanity':
          character.insanity = result;
          break;
        case 'Fatigue':
          character.fatigue = result;
          break;
        default: //nothing
      }
      Provider.of<CharacterModel>(context, listen: false).updateInfo(character);
    }
  }

  Future<void> _showDualValueDialog(BuildContext context, dynamic val1, dynamic val2, String type, String label1, String label2) async {
    final style = type == 'Experience' ? 'field' : 'touchSpin';
    final result = await showDialog<dynamic>(
      context: context,
      builder: (context) {
        return (
          DualValueEditDialog(val1, val2, label1, label2, type, style)
        );
      }
    );
    if (result!=null){
      switch (type) {
        case 'Experience':
          character.spentXp = result['val1'];
          character.xp = result['val2'];
          break;
        case 'Wounds':
          character.hp = result['val2'];
          character.damage = result['val1'];
          break;
        case 'Faith':
          character.currentFaith = result['val1'];
          character.faith = result['val2'];
          break;
      }
      Provider.of<CharacterModel>(context, listen: false).updateInfo(character);
    }
  }


  @override
  Widget build(BuildContext context) {
    return(
        Container(
          //padding: EdgeInsets.all(8.0),
          child: Wrap(
              runSpacing: 1.0,
              spacing: 8.0,
              children: [
                ActionChip(
                    label: Text('Wounds '+(character.hp-character.damage).toString()+'/'+character.hp.toString()),
                    onPressed: () => _showDualValueDialog(context, character.damage, character.hp, 'Wounds', 'Damage taken', 'Total wounds'),
                ),
                ActionChip(
                  label: Text('Faith points '+character.currentFaith.toString()+'/'+character.faith.toString()),
                  onPressed: () => _showDualValueDialog(context, character.currentFaith, character.faith, 'Faith', 'Current', 'Total'),
                ),
                ActionChip(
                    label: Text('Fatigue '+character.fatigue.toString()+'/'+character.getFatigueTreshold().toString()),
                    onPressed: () => _showSingleValueDialog(context, character.fatigue, 'Fatigue'),
                ),
                ActionChip(
                    label: Text('Insanity '+character.insanity.toString()),
                  onPressed: () => _showSingleValueDialog(context, character.insanity, 'Insanity'),
                ),
                ActionChip(
                    label: Text('Experience '+character.spentXp.toString()+'/'+character.xp.toString()),
                  onPressed: () => _showDualValueDialog(context, character.spentXp, character.xp, 'Experience', 'Spent', 'Total'),
                ),
                ActionChip(
                    label: Text('Corruption '+character.corruption.toString()),
                  onPressed: () => _showSingleValueDialog(context, character.corruption, 'Corruption'),
                ),
              ]
          ),
        )
    );
  }
}