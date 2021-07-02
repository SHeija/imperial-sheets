import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_fields/form_builder_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/utils/enums.dart';

class WeaponEditDialog extends StatelessWidget {
  WeaponEditDialog(this.weapon, {this.isNew = false});
  final bool isNew;
  final Weapon weapon;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add weapon')
          : DialogTitleWithButton(
              title: Text('Edit ${weapon.name}'),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onTap: () {
                Navigator.of(context).pop({"choice": DialogChoices.delete});
              },
            ),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'title': weapon.name,
                'description': weapon.description,
                'weight': weapon.weight.toString(),
                'range': weapon.range,
                'rateOfFire': weapon.rateOfFire,
                'damage': weapon.damage,
                'type': weapon.type,
                'penetration': weapon.penetration,
                'clip': weapon.clip,
                'reloadSpeed': weapon.reloadSpeed,
                'special': weapon.special,
                'amount': weapon.amount,
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    key: Key('field_title'),
                    name: "title",
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormBuilderTextField(
                    key: Key('field_description'),
                    name: "description",
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_weight'),
                    name: "weight",
                    decoration: InputDecoration(labelText: 'Weight in kg'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_range'),
                    name: "range",
                    decoration: InputDecoration(labelText: 'Range'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_rateOfFire'),
                    name: "rateOfFire",
                    decoration: InputDecoration(labelText: 'Rate of fire'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_damage'),
                    name: "damage",
                    decoration: InputDecoration(labelText: 'Damage'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_type'),
                    name: "type",
                    decoration: InputDecoration(labelText: 'Damage type'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_penetration'),
                    name: "penetration",
                    decoration: InputDecoration(labelText: 'Penetration'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_clip'),
                    name: "clip",
                    decoration: InputDecoration(labelText: 'Clip'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_reloadSpeed'),
                    name: "reloadSpeed",
                    decoration: InputDecoration(labelText: 'Reload speed'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_special'),
                    name: "special",
                    decoration: InputDecoration(labelText: 'Special'),
                  ),
                  FormBuilderTouchSpin(
                    key: Key('field_amount'),
                    name: "amount",
                    initialValue: weapon.amount,
                    decoration: InputDecoration(labelText: 'Amount'),
                    min: 0,
                    step: 1,
                  ),
                ],
              )),
        ],
      )),
      actions: <Widget>[
        TextButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop({"choice": DialogChoices.cancel});
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              weapon.name = _formKey.currentState.value['title'];
              weapon.description = _formKey.currentState.value['description'];
              weapon.weight = double.parse(_formKey.currentState.value['weight'].replaceAll(',', '.'));
              weapon.range = _formKey.currentState.value['range'];
              weapon.rateOfFire = _formKey.currentState.value['rateOfFire'];
              weapon.damage = _formKey.currentState.value['damage'];
              weapon.type = _formKey.currentState.value['type'];
              weapon.penetration = _formKey.currentState.value['penetration'];
              weapon.clip = _formKey.currentState.value['clip'];
              weapon.reloadSpeed = _formKey.currentState.value['reloadSpeed'];
              weapon.special = _formKey.currentState.value['special'];
              weapon.amount = _formKey.currentState.value['amount'];
              Navigator.of(context).pop({
                "choice": DialogChoices.confirm,
                "payload": weapon,
              });
            }
          },
        ),
      ],
    );
  }
}
