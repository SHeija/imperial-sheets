import 'package:flutter/material.dart';

enum Choices{addItem, addWeapon}

class CornerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Choices>(
      onSelected: (Choices result) { print('pressed lol'); },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
        const PopupMenuItem<Choices>(
          value: Choices.addItem,
          child: Text('Add a item'),
        ),
        const PopupMenuItem<Choices>(
          value: Choices.addWeapon,
          child: Text('Add a talent'),
        ),
      ],
    );
  }
}