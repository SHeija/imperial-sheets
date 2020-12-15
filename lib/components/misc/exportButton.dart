import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';
import 'package:share/share.dart';

class ExportButton extends StatelessWidget {
  void _export(Character exportedCharacter) {
    Share.share(jsonEncode(exportedCharacter.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    Character _character = HiveProvider.of(context).getActiveCharacter();
    return IconButton(
      icon: Icon(Icons.file_upload),
      tooltip: 'Export character as JSON',
      onPressed: () {
        _export(_character);
      },
    );
  }
}
