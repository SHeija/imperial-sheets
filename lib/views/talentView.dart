import 'package:flutter/material.dart';
import '../models/character.dart';

class TalentView extends StatelessWidget {
  final Character character;

  TalentView(this.character);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
          itemCount: character.talents.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(character.talents[index].title),
                subtitle: Text(character.talents[index].description)
            );
          },
        )
    );
  }
}