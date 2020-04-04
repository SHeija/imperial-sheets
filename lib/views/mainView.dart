import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';

class MainView extends StatelessWidget {
  final Character character;

  MainView(this.character);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView (
        children: <Widget>[
          Text(character.name),
          Text(character.description),
          Text('Statit vois olla kivat')
        ],
      )
    );
  }
}
