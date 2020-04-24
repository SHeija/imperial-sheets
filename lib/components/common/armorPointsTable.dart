import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart' as Constants;

class ArmorPointsTable extends StatelessWidget {

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
    Character _character = Provider.of<CharacterModel>(context).getCharacter();
    Map<String, int> armorPoints = _character.getArmorPoints();
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(8.0),
                child: Text('Hit locations', style: Theme.of(context).textTheme.title)
            ),
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
                        child: Text(e.key+':',
                            style: Theme.of(context).textTheme.subtitle),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                            '${(e.value+_character.getStat(Constants.T).getStatBonus())} (${e.value})',
                            style: Theme.of(context).textTheme.body1),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        child: Text('(${_getHitValue(e)})',
                            style: Theme.of(context).textTheme.body1),
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
    );
  }
}
