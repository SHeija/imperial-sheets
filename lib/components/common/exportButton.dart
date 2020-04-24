import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class ExportButton extends StatelessWidget {

  Future<bool> _export(Character exportedCharacter) async {
    try {
      await Share.text(exportedCharacter.id, jsonEncode(exportedCharacter.toJson()), 'raw/json');
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Character _character = Provider.of<CharacterModel>(context).getCharacter();
    return IconButton(
      icon: Icon(Icons.file_upload),
      onPressed: () async {
        final exportSuccess = await _export(_character);
        if (exportSuccess){
          print('Exported succesfully!');
        };
      },
    );
  }
}