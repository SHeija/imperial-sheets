import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:imperial_sheets/models/character.dart';
import '../../utils/constants.dart' as Constants;

class ArmorPointsTable extends StatelessWidget {
  ArmorPointsTable({@required this.character});

  final Character character;

  String _getHitValue(dynamic place) {
    switch (place.key) {
      case 'Head':
        return '1-10';
        break;
      case 'Left Arm':
        return '11-20';
        break;
      case 'Right Arm':
        return '21-30';
        break;
      case 'Body':
        return '31-70';
        break;
      case 'Left Leg':
        return '71-85';
        break;
      case 'Right Leg':
        return '85-100';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> armorPoints = character.getArmorPoints();
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Hit locations',
                      style: Theme.of(context).textTheme.headline6)),
              Container(
                // color: Colors.red,
                child: Table(
                  defaultColumnWidth: IntrinsicColumnWidth(),
                  children: armorPoints.entries
                      .map(
                        (e) => TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                  e.key
                                          .replaceAll('Left', 'L.')
                                          .replaceAll('Right', 'R.') +
                                      ':',
                                  style: Theme.of(context).textTheme.subtitle2),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                  '${(e.value + character.getThisStat(Constants.T).getStatBonus())} (${e.value})',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              child: Text('(${_getHitValue(e)})',
                                  style: Theme.of(context).textTheme.bodyText2),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
