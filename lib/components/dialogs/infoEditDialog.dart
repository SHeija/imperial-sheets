import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../fields/FormTextField.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/utils/enums.dart';

class InfoEditDialog extends StatelessWidget {
  InfoEditDialog(this.character);
  final Character character;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Basic info'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          initialValue: {
            'name': character.name,
            'description': character.description,
          },
          child: Column(
            children: <Widget>[
              FormTextField(
                key: Key('NameField'),
                name: 'name',
                label: 'Name',
              ),
              FormTextField(
                key: Key('DescriptionField'),
                name: 'description',
                label: 'Description',
                maxLines: 5,
              ),
            ],
          ),
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
              character.name = _formKey.currentState.value['name'];
              character.description =
                  _formKey.currentState.value['description'];
              Navigator.of(context)
                  .pop({'choice': DialogChoices.confirm, 'payload': character});
            }
          },
        ),
      ],
    );
  }
}
