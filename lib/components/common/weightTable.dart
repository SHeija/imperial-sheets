import 'package:flutter/material.dart';
import 'package:imperial_sheets/models/character.dart';

class WeightTable extends StatelessWidget {
  WeightTable({@required this.character});
  final Character character;

  @override
  Widget build(BuildContext context) {
    final bool isEncumbered =
        character.getItemWeight() > character.getCarryLimit();
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Weight',
                    style: Theme.of(context).textTheme.headline6,
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: isEncumbered
                    ? Text('Encumbered',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Theme.of(context).errorColor))
                    : Container(),
              ),
              Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: <TableRow>[
                  TableRow(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Equipment:',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${character.getItemWeight()} kg',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Carry limit:',
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${character.getCarryLimit()} kg',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Lift limit:',
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${character.getCarryLimit() * 2} kg',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Push limit:',
                          style: Theme.of(context).textTheme.subtitle2),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text('${character.getCarryLimit() * 4} kg',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
