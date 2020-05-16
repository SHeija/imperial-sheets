import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/common/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/utils/enums.dart';

class ArmorEditDialog extends StatelessWidget {
  ArmorEditDialog(this.armor, {this.isNew = false});
  final bool isNew;
  final Armor armor;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add armor')
          : DialogTitleWithButton(
              title: Text('Edit ${armor.name}'),
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
                'title': armor.name,
                'description': armor.description,
                'weight': armor.weight.toString(),
                'head': armor.head.toString(),
                'leftArm': armor.leftArm.toString(),
                'rightArm': armor.rightArm.toString(),
                'body': armor.body.toString(),
                'leftLeg': armor.leftLeg.toString(),
                'rightLeg': armor.rightLeg.toString(),
                'amount': armor.amount,
                'stackable': armor.stackable,
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
                        InputDecoration(labelText: 'Weight per armor (kg)'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => double.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "head",
                    decoration: InputDecoration(labelText: 'Armor in head'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "leftArm",
                    decoration: InputDecoration(labelText: 'Armor in left arm'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "rightArm",
                    decoration:
                        InputDecoration(labelText: 'Armor in right arm'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "body",
                    decoration: InputDecoration(labelText: 'Armor in body'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "leftLeg",
                    decoration: InputDecoration(labelText: 'Armor in left leg'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTextField(
                    attribute: "rightLeg",
                    decoration:
                        InputDecoration(labelText: 'Armor in right leg'),
                    validators: [
                      FormBuilderValidators.numeric(),
                    ],
                    valueTransformer: (v) => int.parse(v),
                  ),
                  FormBuilderTouchSpin(
                    attribute: "amount",
                    initialValue: armor.amount,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validators: [FormBuilderValidators.required()],
                    min: 0,
                    step: 1,
                  ),
                  FormBuilderSwitch(
                    attribute: 'stackable',
                    initialValue: armor.stackable,
                    label: Text('This armor stacks'),
                  )
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
              armor.name = _formKey.currentState.value['title'];
              armor.description = _formKey.currentState.value['description'];
              armor.weight = _formKey.currentState.value['weight'];
              armor.head = _formKey.currentState.value['head'];
              armor.leftArm = _formKey.currentState.value['leftArm'];
              armor.rightArm = _formKey.currentState.value['rightArm'];
              armor.body = _formKey.currentState.value['body'];
              armor.leftLeg = _formKey.currentState.value['leftLeg'];
              armor.rightLeg = _formKey.currentState.value['rightLeg'];
              armor.amount = _formKey.currentState.value['amount'];
              armor.amount = _formKey.currentState.value['stackable'];
              Navigator.of(context).pop({
                'choice': DialogChoices.confirm,
                'payload': armor,
              });
            }
          },
        ),
      ],
    );
  }
}
