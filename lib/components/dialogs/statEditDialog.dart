import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class StatEditDialog extends StatelessWidget {
  StatEditDialog(this.stat);
  final Stat stat;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
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
                    'unnaturalBonus': stat.unnaturalBonus.toString(),
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
                        max: 5,
                      ),
                      FormBuilderTouchSpin(
                        decoration: InputDecoration(labelText: "Unnatural bonus"),
                        validators: [FormBuilderValidators.min(0)],
                        attribute: "unnaturalBonus",
                        initialValue: stat.unnaturalBonus,
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
              stat.stage = _formKey.currentState.value['stage'];
              stat.unnaturalBonus = _formKey.currentState.value['unnaturalBonus'];
              stat.value =
                  int.parse(_formKey.currentState.value['value']);
              Navigator.of(context).pop(stat);
            }
          },
        ),
      ],
    );
  }
}