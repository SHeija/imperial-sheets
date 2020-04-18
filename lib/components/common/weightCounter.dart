import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class WeightCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Character _character = Provider.of<CharacterModel>(context).getCharacter();
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Weight', style: Theme.of(context).textTheme.headline6,)
            ),
            Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: <TableRow>[
                TableRow(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Equipment:', style: Theme.of(context).textTheme.subtitle2,),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${_character.getItemWeight()} kg', style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Carry limit:', style: Theme.of(context).textTheme.subtitle2),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${_character.getCarryLimit()} kg', style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Lift limit:', style: Theme.of(context).textTheme.subtitle2),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${_character.getCarryLimit()*2} kg', style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ]
                ),
                TableRow(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Push limit:', style: Theme.of(context).textTheme.subtitle2),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text('${_character.getCarryLimit()*4} kg', style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}