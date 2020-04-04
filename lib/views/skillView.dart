import 'package:flutter/material.dart';
import '../models/character.dart';

class SkillView extends StatelessWidget {
  final Character character;

  SkillView(this.character);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
          itemCount: character.skills.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(character.skills[index].title),
                subtitle: Text(character.skills[index].skill)
            );
          },
        )
    );
  }
}