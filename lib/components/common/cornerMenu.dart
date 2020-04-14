import 'package:flutter/material.dart';

enum Choices{addCharacter, addSkill, addItem, addTalent, deleteCharacter}

class CornerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choices>(
      onSelected: (Choices result) { print('pressed lol'); },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
        const PopupMenuItem<Choices>(
          value: Choices.addCharacter,
          child: Text('Add Character'),
        ),
        const PopupMenuItem<Choices>(
          value: Choices.addSkill,
          child: Text('Add a skill'),
        ),
        const PopupMenuItem<Choices>(
          value: Choices.addItem,
          child: Text('Add a item'),
        ),
        const PopupMenuItem<Choices>(
          value: Choices.addTalent,
          child: Text('Add a talent'),
        ),
      ],
    );
  }
}