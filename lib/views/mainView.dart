import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import '../components/containers/infoContainer.dart';
import '../components/containers/statContainer.dart';

class MainView extends StatelessWidget {
  final Character character;

  MainView(this.character);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        InfoContainer(character),
        StatContainer(character.stats)
      ],
    );
  }
}