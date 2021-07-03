import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/fields/FormTouchSpin.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/utils/customValidators.dart';
import 'package:imperial_sheets/utils/enums.dart';

class ItemEditDialog extends StatelessWidget {
  ItemEditDialog(this.item, {this.isNew = false});
  final bool isNew;
  final Item item;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add item')
          : DialogTitleWithButton(
              title: Text('Edit ${item.name}'),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onTap: () {
                Navigator.of(context).pop({
                  "choice": DialogChoices.delete,
                });
              },
            ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'title': item.name,
                'description': item.description,
                'weight': item.weight.toString(),
                'amount': item.amount
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
                    key: Key('field_weight'),
                    name: "weight",
                    label: 'Weight per item (kg)',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTouchSpin(
                    key: Key('field_amount'),
                    name: "amount",
                    decoration: InputDecoration(labelText: 'Amount'),
                    validator: FormBuilderValidators.required(context),
                    min: 0,
                    step: 1,
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
              Navigator.of(context).pop({
                "choice": DialogChoices.cancel,
              });
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              item.name = _formKey.currentState.value['title'];
              item.description = _formKey.currentState.value['description'];
              item.weight = double.parse(
                  _formKey.currentState.value['weight'].replaceAll(',', '.'));
              item.amount = _formKey.currentState.value['amount'];
              Navigator.of(context).pop({
                "choice": DialogChoices.confirm,
                "payload": item,
              });
            }
          },
        ),
      ],
    );
  }
}
