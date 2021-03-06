import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/customValidators.dart';
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
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'title': talent.name,
                'description': talent.description,
                'tier': talent.tier.toString(),
                'cost': talent.cost.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormTextField(
                    key: Key('field_title'),
                    name: "title",
                    label: 'Title',
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormTextField(
                    key: Key('field_description'),
                    name: "description",
                    label: 'Description',
                  ),
                  FormTextField(
                    key: Key('field_tier'),
                    name: "tier",
                    label: 'Tier',
                    validator: FormBuilderValidators.compose(
                      [
                        CustomValidators.numeric(context),
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.min(context, 1),
                        FormBuilderValidators.max(context, 3),
                      ],
                    ),
                  ),
                  FormTextField(
                    key: Key('field_cost'),
                    name: "cost",
                    label: "Exp cost",
                    validator: FormBuilderValidators.compose(
                      [
                        CustomValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ],
                    ),
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
          },
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              talent.name = _formKey.currentState.value['title'];
              talent.description = _formKey.currentState.value['description'];
              talent.tier = int.parse(_formKey.currentState.value['tier']);
              talent.cost = int.parse(_formKey.currentState.value['cost']);
              Navigator.of(context).pop(
                {
                  'choice': DialogChoices.confirm,
                  'payload': talent,
                },
              );
            }
          },
        ),
      ],
    );
  }
}
