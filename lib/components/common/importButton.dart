import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/errorDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class ImportButton extends StatefulWidget{
  ImportButton({Key key}) : super(key:key);
  @override
  _ImportButtonState createState() => _ImportButtonState();
}

class _ImportButtonState extends State<ImportButton> {

  bool loading = false;

  Future<dynamic> _import() async {
    try {
      File file = await FilePicker.getFile(type: FileType.any);
      String json = await file.readAsString();
      Character character = Character.fromJson(jsonDecode(json));
      character.importCleanup();
      return character;
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return ErrorDialog(
              error: e,
              content: Text('Import failed! If you created the file manually, double-check for formatting errors.'),
            );
          }
      );
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Import character'),
      leading: Icon(Icons.file_download),
      onTap: () async {
        setState(() {
          loading = true;
        });
        dynamic result = await _import();
        if (result.runtimeType == Character) {
          await Provider.of<CharacterModel>(context, listen: false).importCharacter(result);
        }
        setState(() {
          loading = false;
        });
      },
      trailing: loading ? Icon(Icons.sync) : Text(''),
    );
  }
}