import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/enums.dart';

class TalentEditDialog extends StatelessWidget {
  TalentEditDialog(this.talent, {this.isNew = false});
  final bool isNew;
  final Talent talent;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add talent')
          : DialogTitleWithButton(
              title: Text('Edit ${talent.name}'),
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
                'title': talent.name,
                'description': talent.description,
                'tier': talent.tier.toString(),
                'cost': talent.cost.toString(),
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
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              talent.name = _formKey.currentState.value['title'];
              talent.description = _formKey.currentState.value['description'];
              talent.tier = _formKey.currentState.value['tier'];
              talent.cost = _formKey.currentState.value['cost'];
              Navigator.of(context).pop({
                'choice': DialogChoices.confirm,
                'payload': talent,
              });
            }
          },
        ),
      ],
    );
  }
}
