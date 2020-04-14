import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class WeaponEditDialog extends StatelessWidget {
  WeaponEditDialog(this.weapon);
  final Weapon weapon;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Edit ${weapon.title}'),
      content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'title': weapon.title,
                    'description': weapon.description,
                    'weight': weapon.weight.toString(),
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
                        valueTransformer: (v) => double.parse(v.replaceAll(',','.')),
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
              weapon.title = _formKey.currentState.value['title'];
              weapon.description = _formKey.currentState.value['description'];
              weapon.weight = _formKey.currentState.value['weight'];
              Navigator.of(context).pop(weapon);
            }
          },
        ),
      ],
    );
  }
}