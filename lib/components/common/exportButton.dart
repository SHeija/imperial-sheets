import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ExportButton extends StatelessWidget {
  void _export(Character exportedCharacter) {
    Share.share(jsonEncode(exportedCharacter.toJson()));
  }

  @override
  Widget build(BuildContext context) {
    Character _character = Provider.of<CharacterModel>(context).getCharacter();
    return IconButton(
      icon: Icon(Icons.file_upload),
      onPressed: () {
        _export(_character);
      },
    );
  }
}
