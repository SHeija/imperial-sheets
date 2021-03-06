import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/experienceEditDialog.dart';
import 'package:imperial_sheets/components/dialogs/singleValueEditDialog.dart';
import 'package:imperial_sheets/models/character.dart';

import '../dialogs/dualValueEditDialog.dart';

class InfoChips extends StatelessWidget {
  InfoChips(this.character);
  final Character character;

  Future<void> _showSingleValueDialog(
      BuildContext context, dynamic value, String type) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (context) {
          return (SingleValueEditDialog(value, type));
        });

    if (result != null) {
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
      character.save();
    }
  }

  Future<void> _showDualValueDialog(BuildContext context, dynamic val1,
      dynamic val2, String type, String label1, String label2) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (context) {
          return (DualValueEditDialog(val1, val2, label1, label2, type));
        });
    if (result != null) {
      switch (type) {
        case 'Wounds':
          character.hp = result['val2'];
          character.currentHp = result['val1'];
          break;
        case 'Fate':
          character.currentFate = result['val1'];
          character.fate = result['val2'];
          break;
      }
      character.save();
    }
  }

  Future<void> _showExperienceDialog(
      BuildContext context, int val1, int val2) async {
    final result = await showDialog<dynamic>(
        context: context,
        builder: (context) {
          return ExperienceEditDialog(val1, val2, character);
        });
    if (result != null) {
      character.spentXp = int.parse(result['val1']);
      character.xp = int.parse(result['val2']);
      character.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
      //padding: EdgeInsets.all(8.0),
      child: Wrap(runSpacing: 1.0, spacing: 8.0, children: [
        ActionChip(
          label: Text('Wounds ' +
              (character.currentHp.toString()).toString() +
              '/' +
              character.hp.toString()),
          onPressed: () => _showDualValueDialog(context, character.currentHp,
              character.hp, 'Wounds', 'Current Wounds', 'Total wounds'),
        ),
        ActionChip(
          label: Text('Fate points ' +
              character.currentFate.toString() +
              '/' +
              character.fate.toString()),
          onPressed: () => _showDualValueDialog(context, character.currentFate,
              character.fate, 'Fate', 'Current', 'Total'),
        ),
        ActionChip(
          label: Text('Fatigue ' +
              character.fatigue.toString() +
              '/' +
              character.getFatigueTreshold().toString()),
          onPressed: () =>
              _showSingleValueDialog(context, character.fatigue, 'Fatigue'),
        ),
        ActionChip(
          label: Text('Insanity ' + character.insanity.toString()),
          onPressed: () =>
              _showSingleValueDialog(context, character.insanity, 'Insanity'),
        ),
        ActionChip(
          label: Text('Corruption ' + character.corruption.toString()),
          onPressed: () => _showSingleValueDialog(
              context, character.corruption, 'Corruption'),
        ),
        ActionChip(
          label: Text('Experience ' +
              character.spentXp.toString() +
              '/' +
              character.xp.toString()),
          onPressed: () => _showExperienceDialog(context, character.spentXp, character.xp),
        ),
      ]),
    ));
  }
}
