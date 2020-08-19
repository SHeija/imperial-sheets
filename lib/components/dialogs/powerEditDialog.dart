import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/enums.dart';

class PowerEditDialog extends StatelessWidget {
  PowerEditDialog(this.power, {this.isNew = false});
  final bool isNew;
  final Power power;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add power')
          : DialogTitleWithButton(
              title: Text(power.name),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onTap: () {
                Navigator.of(context).pop({'choice': DialogChoices.delete});
              },
            ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {
                'name': power.name,
                'description': power.description,
                'action': power.action,
                'focusPower': power.focusPower,
                'range': power.range,
                'sustained': power.sustained,
                'subType': power.subType,
                'effect': power.effect,
                'cost': power.cost.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: 'name',
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'description',
                    decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Flavor description'),
                  ),
                  FormBuilderTextField(
                    attribute: 'action',
                    decoration: InputDecoration(
                      labelText: 'Action',
                      hintText: 'e.g Half Action',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'focusPower',
                    decoration: InputDecoration(
                      labelText: 'Focus Power',
                      hintText: 'e.g. +0 Opposed Willpower test',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'range',
                    decoration: InputDecoration(
                      labelText: 'Range',
                      hintText: 'e.g. 20m x psy rating',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'sustained',
                    decoration: InputDecoration(
                      labelText: 'Sustained',
                      hintText: 'e.g. Half Action',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'subType',
                    decoration: InputDecoration(
                        labelText: 'Subtype',
                        hintText: 'e.g. Attack, Concentration'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'effect',
                    decoration: InputDecoration(
                      labelText: 'Effect',
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "cost",
                    decoration: InputDecoration(labelText: "Exp cost"),
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.required(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop({'choice': DialogChoices.cancel});
            }),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              power.name = _formKey.currentState.value['name'];
              power.description = _formKey.currentState.value['description'];
              power.action = _formKey.currentState.value['action'];
              power.focusPower = _formKey.currentState.value['focusPower'];
              power.range = _formKey.currentState.value['range'];
              power.sustained = _formKey.currentState.value['sustained'];
              power.subType = _formKey.currentState.value['subType'];
              power.effect = _formKey.currentState.value['effect'];
              power.cost = _formKey.currentState.value['cost'];
              Navigator.of(context).pop({
                'choice': DialogChoices.confirm,
                'payload': power,
              });
            }
          },
        ),
      ],
    );
  }
}
