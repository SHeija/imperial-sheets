import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/common/stepIndicator.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class StatTile extends StatelessWidget {
  StatTile(this.stat, this.index);
  final Stat stat;
  final int index;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // DIALOG
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(stat.name),
          content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'value': stat.value.toString(),
                        'stage': stat.stage.toString(),
                      },
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "value",
                            decoration: InputDecoration(labelText: "Value"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.max(100),
                            ],
                          ),
                          FormBuilderTouchSpin(
                            decoration: InputDecoration(labelText: "Stage"),
                            validators: [FormBuilderValidators.max(5)],
                            attribute: "stage",
                            initialValue: stat.stage,
                            min: 0,
                            step: 1,
                          ),
                        ],
                      )),
                ],
              )),
          actions: <Widget>[
            FlatButton(
                child: Text('Regret'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.saveAndValidate()) {
                  Stat newStat = stat;
                  newStat.stage = _formKey.currentState.value['stage'];
                  newStat.value =
                      int.parse(_formKey.currentState.value['value']);
                  Navigator.of(context).pop(newStat);
                }
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updateStats(result, index);
    }
  }

  // TILE
  @override
  Widget build(BuildContext context) {
    const double cellPadding = 8.0; // TODO

    return (SizedBox(
      width: 190,
      child: GestureDetector(
        onLongPress: () => _showEditDialog(context),
        child: Card(
          child: Column(
            children: <Widget>[
              Table(
                  //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FractionColumnWidth(0.75),
                    1: FractionColumnWidth(0.25)
                  }, children: [
                TableRow(children: <Widget>[
                  Container(
                    child: Text(stat.name,
                        style: Theme.of(context).textTheme.headline6),
                    padding: EdgeInsets.only(
                        left: cellPadding,
                        top: cellPadding,
                        right: cellPadding),
                  ),
                  Container(
                    child: Text(stat.value.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    padding: EdgeInsets.only(
                        left: cellPadding,
                        top: cellPadding,
                        right: cellPadding),
                    alignment: Alignment.center,
                  ),
                ]),
                TableRow(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(stat.short,
                            style: Theme.of(context).textTheme.bodyText2),
                        padding: EdgeInsets.only(
                            left: cellPadding,
                            bottom: cellPadding,
                            right: cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: StepIndicator(5, stat.stage,
                            Theme.of(context).accentColor, Colors.grey),
                        padding: EdgeInsets.only(
                            left: cellPadding,
                            bottom: cellPadding,
                            right: cellPadding),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                  Container(
                      child: Chip(
                          label: Text(stat.getStatBonus().toString()),
                          padding: EdgeInsets.all(0)),
                      padding: EdgeInsets.only(
                          left: cellPadding,
                          bottom: cellPadding,
                          right: cellPadding),
                      alignment: Alignment.topCenter),
                ]),
              ]),
            ],
          ),
        ),
      ),
    ));
  }
}
