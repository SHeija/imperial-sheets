import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
                    attribute: "title",
                    decoration: InputDecoration(labelText: 'Title'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: "description",
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  FormBuilderTextField(
                    attribute: "weight",
                    decoration: InputDecoration(labelText: 'Weight in kg'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) =>
                        double.parse(v.replaceAll(',', '.')),
                  ),
                  FormBuilderTextField(
                    attribute: "range",
                    decoration: InputDecoration(labelText: 'Range'),
                  ),
                  FormBuilderTextField(
                    attribute: "rateOfFire",
                    decoration: InputDecoration(labelText: 'Rate of fire'),
                  ),
                  FormBuilderTextField(
                    attribute: "damage",
                    decoration: InputDecoration(labelText: 'Damage'),
                  ),
                  FormBuilderTextField(
                    attribute: "type",
                    decoration: InputDecoration(labelText: 'Damage type'),
                  ),
                  FormBuilderTextField(
                    attribute: "penetration",
                    decoration: InputDecoration(labelText: 'Penetration'),
                  ),
                  FormBuilderTextField(
                    attribute: "clip",
                    decoration: InputDecoration(labelText: 'Clip'),
                  ),
                  FormBuilderTextField(
                    attribute: "reloadSpeed",
                    decoration: InputDecoration(labelText: 'Reload speed'),
                  ),
                  FormBuilderTextField(
                    attribute: "special",
                    decoration: InputDecoration(labelText: 'Special'),
                  ),
                  FormBuilderTouchSpin(
                    attribute: "amount",
                    initialValue: weapon.amount,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validators: [FormBuilderValidators.required()],
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
              Navigator.of(context).pop({"choice": DialogChoices.cancel});
            }),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              weapon.name = _formKey.currentState.value['title'];
              weapon.description = _formKey.currentState.value['description'];
              weapon.weight = _formKey.currentState.value['weight'];
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
