import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/common/armorPointsTable.dart';
import 'package:imperial_sheets/components/containers/armorContainer.dart';

class ArmorAndMovementContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ArmorPointsTable(),
      ],
    );
  }
}