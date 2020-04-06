import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import '../components/basicInfo.dart';
import '../components/statGrid.dart';

class MainView extends StatelessWidget {
  final Character character;

  MainView(this.character);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        BasicInfo(character),
        StatGrid(character.stats)
      ],
    );
  }
}