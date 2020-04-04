import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';

class InventoryView extends StatelessWidget {
  final Character character;

  InventoryView(this.character);

  @override
  Widget build(BuildContext context) {
    return Center(

        child: ListView.builder(
          itemCount: character.items.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
                title: Text(character.items[index].title),
                subtitle: Text(character.items[index].description)
            );
          },
        )
    );
  }
}
