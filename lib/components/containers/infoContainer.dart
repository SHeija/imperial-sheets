import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';

class InfoContainer extends StatelessWidget {
  final Character character;
  InfoContainer(this.character);

  @override
  Widget build(BuildContext context) {
    return(
      Container(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
            children: <Widget>[
              Text(character.name),
              Text(character.description),
              Wrap(
                runSpacing: 1.0,
                spacing: 8.0,
                children: [
                  Chip(
                      label: Text('Hit points '+(character.hp-character.damage).toString()+'/'+character.hp.toString())
                  ),
                  Chip(
                    label: Text('Faith points '+character.currentFaith.toString()+'/'+character.faith.toString()),
                  ),
                  Chip(
                    label: Text('Fatigue '+character.fatigue.toString()+'/'+character.getFatigueTreshold().toString())
                  ),
                  Chip(
                    label: Text('Insanity '+character.insanity.toString())
                  ),
                  Chip(
                      label: Text('Experience '+character.spentXp.toString()+'/'+character.xp.toString())
                  ),
                  Chip(
                    label: Text('Corruption '+character.corruption.toString())
                  ),
                ]
              ),
            ],
          )
        )
      )
    );
  }
}