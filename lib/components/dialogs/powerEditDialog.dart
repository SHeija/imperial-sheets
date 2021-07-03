import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/customValidators.dart';
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
              autovalidateMode: AutovalidateMode.always,
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
                  FormTextField(
                    key: Key('field_name'),
                    name: 'name',
                    label: 'Name',
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormTextField(
                    key: Key('field_description'),
                    name: 'description',
                    label: 'Description',
                    hint: 'Flavor description',
                  ),
                  FormTextField(
                    key: Key('field_action'),
                    name: 'action',
                    label: 'Action',
                    hint: 'e.g Half Action',
                  ),
                  FormTextField(
                    key: Key('field_focusPower'),
                    name: 'focusPower',
                    label: 'Focus Power',
                    hint: 'e.g. +0 Opposed Willpower test',
                  ),
                  FormTextField(
                    key: Key('field_range'),
                    name: 'range',
                    label: 'Range',
                    hint: 'e.g. 20m x psy rating',
                  ),
                  FormTextField(
                    key: Key('field_sustained'),
                    name: 'sustained',
                    label: 'Sustained',
                    hint: 'e.g. Half Action',
                  ),
                  FormTextField(
                    key: Key('field_subType'),
                    name: 'subType',
                    label: 'Subtype',
                    hint: 'e.g. Attack, Concentration'),
                  FormTextField(
                    key: Key('field_effect'),
                    name: 'effect',
                    label: 'Effect',
                  ),
                  FormTextField(
                    key: Key('field_cost'),
                    name: "cost",
                    label: "Exp cost",
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
              Navigator.of(context).pop({'choice': DialogChoices.cancel});
            }),
        TextButton(
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
              power.cost = int.parse(_formKey.currentState.value['cost']);
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
