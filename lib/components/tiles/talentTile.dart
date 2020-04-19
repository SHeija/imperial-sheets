import 'package:flutter/material.dart';
import 'package:imperial_sheets/components/dialogs/talentEditDialog.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class TalentTile extends StatelessWidget {
  TalentTile(this.talent, this.index);
  final Talent talent;
  final int index;

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return TalentEditDialog(talent);
      },
    );
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false)
          .updateTalents(result, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    double cellPadding = 8.0;
    return GestureDetector(
      onLongPress: () => _showEditDialog(context),
      child: Card(
        child: Column(
          children: <Widget>[
            Table(
              //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(0.75),
                1: FractionColumnWidth(0.25)
              },
              children: [
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(talent.name,
                          style: Theme.of(context).textTheme.headline6),
                      padding: EdgeInsets.all(cellPadding),
                    ),
                    Container(
                      child: Text('Tier ${talent.tier}',
                          style: Theme.of(context).textTheme.subtitle2),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text(talent.description,
                          style: Theme.of(context).textTheme.bodyText2),
                      padding: EdgeInsets.all(cellPadding),
                      alignment: Alignment.topLeft,
                    ),
                    Container(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
