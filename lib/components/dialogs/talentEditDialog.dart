import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/models/datamodels.dart';

class TalentEditDialog extends StatelessWidget {
  TalentEditDialog(this.talent);
  final Talent talent;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Edit ${talent.title}'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {
                'title': talent.title,
                'description': talent.description,
                'tier': talent.tier.toString()
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
                    attribute: "tier",
                    decoration: InputDecoration(labelText: 'Tier'),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(1),
                      FormBuilderValidators.max(3)
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
              Navigator.of(context).pop();
            }),
        FlatButton(
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              talent.title = _formKey.currentState.value['title'];
              talent.description = _formKey.currentState.value['description'];
              talent.tier = _formKey.currentState.value['tier'];
              Navigator.of(context).pop(talent);
            }
          },
        ),
      ],
    );
  }
}
