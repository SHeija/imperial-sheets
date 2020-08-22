import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
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
              key: _formKey,
              initialValue: {
                'title': item.name,
                'description': item.description,
                'weight': item.weight.toString(),
                'amount': item.amount
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
                    decoration:
                        InputDecoration(labelText: 'Weight per item (kg)'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => double.parse(v),
                  ),
                  FormBuilderTouchSpin(
                    attribute: "amount",
                    initialValue: item.amount,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validators: [FormBuilderValidators.required()],
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
        FlatButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop({
                "choice": DialogChoices.cancel,
              });
            }),
        FlatButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              item.name = _formKey.currentState.value['title'];
              item.description = _formKey.currentState.value['description'];
              item.weight = _formKey.currentState.value['weight'];
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
