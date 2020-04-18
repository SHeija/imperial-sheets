import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart' as Contants;

class SpeedTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Character _character = Provider.of<CharacterModel>(context).getCharacter();
    final speed = _character.getStat(Contants.AG).getStatBonus();
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
              child: Text('Movement', style: Theme.of(context).textTheme.headline6),
            ),
            Table(
              // border: TableBorder.all(color: Theme.of(context).accentColor, width: 2.0),
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('Half move', style: Theme.of(context).textTheme.subtitle1),
                          alignment: Alignment.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(speed.toString()),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('Full move', style: Theme.of(context).textTheme.subtitle1),
                          alignment: Alignment.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text((speed * 2).toString()),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('Charge', style: Theme.of(context).textTheme.subtitle1),
                          alignment: Alignment.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text((speed * 3).toString()),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('Run', style: Theme.of(context).textTheme.subtitle1),
                          alignment: Alignment.center,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text((speed * 6).toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
