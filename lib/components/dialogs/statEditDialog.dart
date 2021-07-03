import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/fields/FormTouchSpin.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/customValidators.dart';

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
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'value': stat.value.toString(),
                'stage': stat.stage,
                'unnaturalBonus': stat.unnaturalBonus,
                'cost': stat.cost.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormTextField(
                    key: Key('field_value'),
                    name: "value",
                    label: "Value",
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.max(context, 100),
                    ]),
                  ),
                  FormTouchSpin(
                    key: Key('field_stage'),
                    decoration: InputDecoration(labelText: "Stage"),
                    name: "stage",
                    min: 0,
                    step: 1,
                    max: 5,
                  ),
                  FormTouchSpin(
                    key: Key('field_unnatural_bonus'),
                    decoration: InputDecoration(labelText: "Unnatural bonus"),
                    name: "unnaturalBonus",
                    min: 0,
                    step: 1,
                  ),
                  FormTextField(
                    key: Key('field_cost'),
                    name: "cost",
                    label: "Exp cost in total",
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
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
