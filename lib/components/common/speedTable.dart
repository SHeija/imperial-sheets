import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';
import '../../utils/constants.dart' as Contants;

class SpeedTable extends StatelessWidget {
  SpeedTable(this.character);
  final Character character;

  @override
  Widget build(BuildContext context) {
    var speed = character.stats
        .firstWhere((element) => element.name == Contants.AG)
        .getStatBonus();

    return (Container(
      child: Column(
        children: <Widget>[
          // Text('Movement', style: Theme.of(context).textTheme.headline6),
          Table(
            // border: TableBorder.all(color: Theme.of(context).accentColor, width: 2.0),
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Card(
                    child: Column(
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
                  ),
                  Card(
                    child: Column(
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
                  ),
                  Card(
                    child: Column(
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
                  ),
                  Card(
                    child: Column(
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
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
