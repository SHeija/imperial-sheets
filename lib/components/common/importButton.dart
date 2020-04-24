import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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

  Future<Character> _import() async {
    File file = await FilePicker.getFile(type: FileType.custom, allowedExtensions: ['json', 'txt']);
    String json = await file.readAsString();
    Character character = Character.fromJson(jsonDecode(json))
      ..id = null;
    return character;
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
        Character imported = await _import();
        await Provider.of<CharacterModel>(context, listen: false).importCharacter(imported);
        setState(() {
          loading = false;
        });
      },
      trailing: loading ? Icon(Icons.sync) : Text(''),
    );
  }
}