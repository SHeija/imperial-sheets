import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/aptitudeChips.dart';
import 'package:imperial_sheets/components/dialogs/aptitudeEditDialog.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/utils/enums.dart';

class AptitudeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Character character = HiveProvider.of(context).getActiveCharacter();

    Future<void> _showEditDialog(BuildContext context) async {
      final result = await showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AptitudeEditDialog(
            character.aptitudes,
          );
        },
      );
      if (result != null) {
        switch (result['choice']) {
          case DialogChoices.confirm:
            character.aptitudes = result['payload'];
            character.save();
            break;
          default:
            break;
        }
      }
    }

    return GestureDetector(
      onLongPress: () {
        _showEditDialog(context);
      },
      child: Container(
        child: Card(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: AptitudeChips(character.aptitudes),
        )),
      ),
    );
  }
}
