import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/models/attributes.dart';

class StatEditDialog extends StatelessWidget {
  StatEditDialog(this.stat);
  final Stat stat;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(stat.name),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FormBuilder(
              key: _formKey,
              initialValue: {
                'value': stat.value.toString(),
                'stage': stat.stage.toString(),
                'unnaturalBonus': stat.unnaturalBonus.toString(),
                'cost': stat.cost.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    key: Key('field_value'),
                    attribute: "value",
                    decoration: InputDecoration(labelText: "Value"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.max(100),
                    ],
                  ),
                  FormBuilderTouchSpin(
                    key: Key('field_stage'),
                    decoration: InputDecoration(labelText: "Stage"),
                    attribute: "stage",
                    initialValue: stat.stage,
                    min: 0,
                    step: 1,
                    max: 5,
                  ),
                  FormBuilderTouchSpin(
                    key: Key('field_unnatural_bonus'),
                    decoration: InputDecoration(labelText: "Unnatural bonus"),
                    attribute: "unnaturalBonus",
                    initialValue: stat.unnaturalBonus,
                    min: 0,
                    step: 1,
                  ),
                  FormBuilderTextField(
                    key: Key('field_cost'),
                    attribute: "cost",
                    decoration: InputDecoration(labelText: "Exp cost in total"),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
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
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              stat.value = int.parse(_formKey.currentState.value['value']);
              stat.stage = _formKey.currentState.value['stage'];
              stat.unnaturalBonus =
                  _formKey.currentState.value['unnaturalBonus'];
              stat.cost = int.parse(_formKey.currentState.value['cost']);
              Navigator.of(context).pop(stat);
            }
          },
        ),
      ],
    );
  }
}
